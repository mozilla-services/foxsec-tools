#!/usr/bin/env python3
"""
Utility Cloud File Storage methods to abstract away from specific cloud providers.
Currently only S3 is supported.
"""

import argparse
import boto3
import os

def upload_file(locfile, desttype, destloc, destname):
    """
    Upload a file to cloud file storage
    
    Args:
        locfile (str):    The local file to upload
        desttype (str):   The destination type, currently only 's3' is supported
        destloc (str):    The destination location, for s3 this is the bucket name
        destname (str):   The destination name, for s3 this may include a path
    """
    if desttype == 's3':
        s3 = boto3.client('s3',
                          aws_access_key_id=os.environ['AWS_ACCESS_KEY'],
                          aws_secret_access_key=os.environ['AWS_SECRET_KEY'],)
        s3.upload_file(locfile, destloc, destname)
    else:
        raise ValueError('Destination type not supported, currently only s3 is supported.')

def download_file(locfile, srctype, srcloc, srcname):
    """
    Download a file from cloud file storage
    
    Args:
        locfile (str):    The local file to download to
        srctype (str):    The source type, currently only 's3' is supported
        srcloc (str):     The source location, for s3 this is the bucket name
        srcname (str):    The source name, for s3 this may include a path
    """
    if srctype == 's3':
        s3 = boto3.client('s3',
                          aws_access_key_id=os.environ['AWS_ACCESS_KEY'],
                          aws_secret_access_key=os.environ['AWS_SECRET_KEY'],)
        s3.download_file(srcloc, srcname, locfile)
    else:
        raise ValueError('Source type not supported, currently only s3 is supported.')


def check_op(value):
    if value != 'upload' and value != 'download':
        raise argparse.ArgumentTypeError("operation must be \'upload\' or \'download\'")
    return value


def get_args():
    parser = argparse.ArgumentParser(description=__doc__)

    parser.add_argument('op',
                        type=check_op,
                        help='operation - \'upload\' or \'download\'')

    parser.add_argument('-f', '--local-file',
                        required=True,
                        help='local file')
    
    parser.add_argument('-t', '--dest-type',
                        default='s3',
                        help='destination type')
    
    parser.add_argument('-l', '--dest-loc',
                        required=True,
                        help='destination location')
    
    parser.add_argument('-n', '--dest-name',
                        required=True,
                        help='destination name')
    
    return parser.parse_args()


def main():
    args = get_args()
    if args.op == 'upload':
        upload_file(args.local_file, args.dest_type, args.dest_loc, args.dest_name)
    elif args.op == 'download':
        download_file(args.local_file, args.dest_type, args.dest_loc, args.dest_name)


if __name__ == '__main__':
    main()
