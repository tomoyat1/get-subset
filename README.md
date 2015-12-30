# get-subset
A simple script that returns a list of all of the characters found in
.erb, .rb, .js, .html, and .txt files that are in the specified directory
and its subdirectories. Useful for making subset embedded fonts for use as
web fonts (for certain languages that have bazillions of characters).

## Usage
`ruby ./get-subset <directory> [--exclude directory]`
## Features
Rather feature-poor at the moment. The types of files that this script looks into
are hard-coded at the moment. I would like to make that user-specified soon.
