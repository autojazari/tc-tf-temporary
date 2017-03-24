#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
@author: Sam Mohamed
This module will by triggered by the Jenkins Job ``Create S3 Bucket``.

The purpose of this module is to manage the dynamic creation of one or more S3 buckets.
The module updated the ``variables.tf`` file with the bucket names,
then uses subprocess to call the ``terraform apply`` command as required.

Usage:
    This module will be called by the jenkins job as
    $ python jenkins.py test.sam.mp.org AKInnnn u72qibQUoBEnnn us-east-1
Arguments:
    S3_BUCKET_NAMES: Comma separated list of bucket names
    AWS_ACCESS_KEY_ID: AWS Access Key
    AWS_SECRET_ACCESS_KEY: AWS Secret Access Key
    REGION: AWS Region Id

"""
import os
import sys
import argparse
import subprocess


def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("s3_bucket_names")
    parser.add_argument("aws_access_key_id")
    parser.add_argument("aws_secret_access_key")
    parser.add_argument("region")

    return parser.parse_args()


def generate_variables_tf(s3_bucket_names, region, output_count):
    with open('variables.tf.template', 'r') as infile:
        template = ''.join(infile.readlines())

    with open('variables.tf', 'a') as outfile:
        for i in range(len(s3_bucket_names)):
            tmp = '%s' % template
            tmp = tmp.replace('$s3__bucketname', s3_bucket_names[i])
            tmp = tmp.replace('$s3_bucket', 'bucket'+str(int(i+output_count)))
            outfile.write(tmp)
            outfile.write('\n')


def get_current_bucket_count():
    output_count = 1

    with open('outputs.tf', 'r') as infile:
        for line in infile.readlines():
            if line.find('output') >= 0:
                output_count += 1

    return output_count


def generate_outputs_tf(s3_bucket_names, output_count):
    with open('outputs.tf.template', 'r') as infile:
        template = ''.join(infile.readlines())

    with open('outputs.tf', 'a') as outfile:
        for i in range(len(s3_bucket_names)):
            outfile.write(template.replace('$s3_bucket', 'bucket'+str(int(i+output_count))))
            outfile.write('\n')


def generate_buckets(s3_bucket_names, region, output_count):
    provider_template = """provider "aws" {
       region = "${var.region}"
    }
    """
    with open('s3.tf.template', 'r') as infile:
        template = ''.join(infile.readlines())

    with open('s3.tf', 'a') as outfile:
        for i in range(len(s3_bucket_names)):
            outfile.write(template.replace('$s3_bucket', 'bucket'+str(int(i+output_count))))
            outfile.write('\n')


def run_terraform():
    cmd = 'terraform remote pull'
    code = subprocess.call(cmd, shell=True)
    cmd = 'terraform apply -var-file ../../terraform.tfvars'
    code = subprocess.call(cmd, shell=True)
    if code == 0:
        cmd = 'terraform remote push'
        code = subprocess.call(cmd, shell=True)
        cleanup()
    sys.exit(code)

def cleanup():
    subprocess.call("svn commit -m 'generated s3 buckets via jenkins job'", shell=True)


def main():
    args = parse_args()

    # split bucket names by commas
    s3_bucket_names = [name.strip() for name in args.s3_bucket_names.split(',')]

    output_count = get_current_bucket_count()
    generate_variables_tf(s3_bucket_names, args.region, output_count)
    generate_outputs_tf(s3_bucket_names, output_count)
    generate_buckets(s3_bucket_names, args.region, output_count)
    run_terraform()
    cleanup()

if __name__ == '__main__':
    main()