#!/usr/bin/env python
"""Generate tag cloud HTML for jekyll posts.
"""


import math
import os
import urllib
import sys


def find_tags(postfile):
    f = open(postfile)
    tags = ''
    marker_count = 0
    for l in f.xreadlines():
	if l == '---\n':
	    marker_count += 1
	    if marker_count == 2:
		break
	    continue

	if l.startswith('tags:'):
	    tags = l[5:].strip()
	    break

    # remove brackets
    lb = tags.find('[')
    rb = tags.rfind(']')
    tags = tags[lb+1:rb]

    return [t.strip() for t in tags.split(',')]


if __name__ == '__main__':
    cloud_size = int(sys.argv[1])
    max_ranks = int(sys.argv[2])
    postpath = os.path.join(sys.argv[3], '_posts')
    posts = [i for i in os.listdir(postpath) if not os.path.isdir(i)]

    counts = {}
    for p in posts:
	tags = find_tags(os.path.join(postpath, p))
	for t in tags:
	    if t in counts.keys():
		counts[t] += 1
	    else:
		counts[t] = 1

    # grab the top N tags
    sorted_keys = sorted(counts.keys(), 
			 lambda x,y: cmp(counts[x], counts[y]),
			 reverse=True)

    # this code follows the algorithm in MT
    max_count = counts[sorted_keys[0]]
    min_count = counts[sorted_keys[-1]]
    factor = 1

    if max_count - min_count == 0:
	min_count -= max_ranks
    else:
	factor = (max_ranks - 1) / math.log(max_count - min_count + 1)

    if len(sorted_keys) < max_ranks:
	factor *= (len(sorted_keys) / float(max_ranks))

    # generate HTML in alpha order for top N tags
    print "<ul>"
    for t in sorted(sorted_keys[:cloud_size]):
	rank = max_ranks - int(math.log(counts[t] - min_count + 1) * factor)
	print "  <li class='cloud-rank-%d' rel='tag'>"\
	    "<a href='http://www.google.com/search?q=%s+site%%3Ametajack.im'>"\
	    "%s</a></li>" % \
	    (rank, urllib.quote_plus(t), t)
    print "</ul>"
