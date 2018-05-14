<<<<<<< HEAD
from setuptools import setup

# NOTE: This is currently duplicated from the gitdb.__init__ module, because
# that's just how you write a setup.py (nobody reads this stuff out of the
# module)

__author__ = "Sebastian Thiel"
__contact__ = "byronimo@gmail.com"
__homepage__ = "https://github.com/gitpython-developers/gitdb"
version_info = (2, 0, 3)
__version__ = '.'.join(str(i) for i in version_info)

setup(
    name="gitdb2",
    version=__version__,
    description="Git Object Database",
    author=__author__,
    author_email=__contact__,
    url=__homepage__,
    packages=('gitdb', 'gitdb.db', 'gitdb.utils', 'gitdb.test'),
    license="BSD License",
    zip_safe=False,
    install_requires=['smmap2 >= 2.0.0'],
    long_description="""GitDB is a pure-Python git object database""",
    # See https://pypi.python.org/pypi?%3Aaction=list_classifiers
    classifiers=[
        "Development Status :: 5 - Production/Stable",
        "Environment :: Console",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: BSD License",
        "Operating System :: OS Independent",
        "Operating System :: POSIX",
        "Operating System :: Microsoft :: Windows",
        "Operating System :: MacOS :: MacOS X",
        "Programming Language :: Python",
        "Programming Language :: Python :: 2",
        "Programming Language :: Python :: 2.6",
        "Programming Language :: Python :: 2.7",
        "Programming Language :: Python :: 3",
        "Programming Language :: Python :: 3.2",
        "Programming Language :: Python :: 3.3",
        "Programming Language :: Python :: 3.4",
        "Programming Language :: Python :: 3.5",
    ]
=======
<<<<<<< HEAD
#  Copyright (c) 2015 Cisco Systems
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
=======
#  Copyright (c) 2015-2018 Cisco Systems, Inc.
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to
#  deal in the Software without restriction, including without limitation the
#  rights to use, copy, modify, merge, publish, distribute, sublicense, and/or
#  sell copies of the Software, and to permit persons to whom the Software is
>>>>>>> 8ac2960b6bc0c6472e24bb0e5fee15163ebb31bb
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
<<<<<<< HEAD
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.
=======
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
#  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
#  DEALINGS IN THE SOFTWARE.
>>>>>>> 8ac2960b6bc0c6472e24bb0e5fee15163ebb31bb

import setuptools

setuptools.setup(
    packages=setuptools.find_packages(),
    pbr=True,
    setup_requires=['pbr']
<<<<<<< HEAD
>>>>>>> first commit
=======
>>>>>>> d2d2dce8a61ea35094b5fef4afb8aa48f28a985d
>>>>>>> 8ac2960b6bc0c6472e24bb0e5fee15163ebb31bb
)
