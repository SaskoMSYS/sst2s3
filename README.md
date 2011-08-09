# Introduction

**NOTE: This is beta software. It has been used to perform a
        successfull migration of a production 0.7.x cassandra cluster
        to 0.8.x, but there are no guarantees it will work in every
        environment.**

Basic steps for migrating a cassandra node:

1. On the old node, drain/flush the commitlogs with `nodetool drain`.
1. Shutdown cassandra on the node.
1. Run `sst2s3` to upload sstables to S3.
1. On new node, run `s32sst` to pull sstables from S3 and extract to
the current data directory.
1. Start cassandra on new node.

Notes:

* A packing list will be uploaded that includes SHA1 sums to verify
sstable integrity during extraction.
* The owner/group name of each sstable file will be included in the
packing list and they will be used (if possible) to restore
owner/group.
* The data directory will be automatically detected from
/etc/cassandra/cassandra.yaml, if possible. Does not support multiple
data directories.
* Any previous sstable snapshots will not be uploaded.
* You may want to run `nodetool scrub` on the new node; depends on environment.

## sst2s3

This will tarball and upload sstables to S3.

```
Options:
     --s3-key, -s <s>:   S3 Key
  --s3-secret, -e <s>:   S3 Secret
  --s3-bucket, -b <s>:   S3 Bucket+Path (eg: bucket_name/path/to/storedir)
        --dir, -d <s>:   Data Directory
     --tmpdir, -t <s>:   Directory for tempfiles (default: /tmp)
        --verbose, -v:   Print checkpoints when archiving
            --all, -a:   Backup all keyspaces
        --version, -r:   Print version and exit
           --help, -h:   Show this message
```

## s32sst

This will download the sstable tarballs from S3 and extract them to
the local cassandra directory.

```
Options:
     --s3-key, -s <s>:   S3 Key
  --s3-secret, -e <s>:   S3 Secret
  --s3-bucket, -b <s>:   S3 Bucket+Path (eg: bucket_name/path/to/sstdir)
        --dir, -d <s>:   Data Directory
     --tmpdir, -t <s>:   Directory for tempfiles (default: /tmp)
      --owner, -o <s>:   Override owner for files
      --group, -g <s>:   Override group for files
        --verbose, -v:   Print checkpoints during extract
            --all, -a:   Restore all keyspaces
        --version, -r:   Print version and exit
           --help, -h:   Show this message
```

## Contributing to sst2s3
 
* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 Librato, Inc. See LICENSE.txt for further details.

