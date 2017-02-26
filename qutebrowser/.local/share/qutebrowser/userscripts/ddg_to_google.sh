#!/bin/sh

# search this query with google instead

new_url=$(echo "${QUTE_URL}" | sed 's/?q=/?q=!g+/')

echo "open ${new_url}" >> "${QUTE_FIFO}"
