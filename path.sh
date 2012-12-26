PATH=/usr/local/share/python:/Applications:/Users/durden/Documents/code/bin:$PATH

# Setting PATH for Python 2.7
PATH="/Library/Frameworks/Python.framework/Versions/2.7/bin:${PATH}"
export PATH

NODE_PATH="/usr/local/lib/node_modules:${NODE_PATH}"
export NODE_PATH

# Put homebrew apps before standard OS X
PATH=/usr/local/bin:$PATH
export PATH

# Local postgres.app
PATH=/Applications/Postgres.app/Contents/MacOS/bin/:$PATH
export PATH

# Non-homebrew python path
#export PYTHONPATH=/usr/local/lib/python2.7/site-packages:$PYTHONPATH
