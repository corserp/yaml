#  Copyright (c) 2015 Cisco Systems
#
#  Permission is hereby granted, free of charge, to any person obtaining a copy
#  of this software and associated documentation files (the "Software"), to deal
#  in the Software without restriction, including without limitation the rights
#  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#  copies of the Software, and to permit persons to whom the Software is
#  furnished to do so, subject to the following conditions:
#
#  The above copyright notice and this permission notice shall be included in
#  all copies or substantial portions of the Software.
#
#  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#  THE SOFTWARE.

import testtools

import molecule.validators as validators


class TestValidators(testtools.TestCase):

    TRAILING_NEWLINE_FAILED = ['line1', 'line2', '\n']
    TRAILING_NEWLINE_SUCCESS = ['line1', 'line2', '']
    TRAILING_WHITESPACE_FAILED = ['line1', 'line2', 'line3    ']
    TRAILING_WHITESPACE_FAILED_MULTILINE = ['line1', 'line2    ', 'line3', 'line4    ']
    TRAILING_WHITESPACE_SUCCESS = ['line1', 'line2', 'line3']

    def test_trailing_newline_failed(self):
        res = validators.trailing_newline(TestValidators.TRAILING_NEWLINE_FAILED)
        self.assertTrue(res)

    def test_trailing_newline_success(self):
        res = validators.trailing_newline(TestValidators.TRAILING_NEWLINE_SUCCESS)
        self.assertIsNone(res)

    def test_trailing_whitespace_failed(self):
        res = validators.trailing_whitespace(TestValidators.TRAILING_WHITESPACE_FAILED)
        self.assertTrue(res)

    def test_trailing_whitespace_failed_multiline(self):
        res = validators.trailing_whitespace(TestValidators.TRAILING_WHITESPACE_FAILED_MULTILINE)
        self.assertItemsEqual(res, [2, 4])

    def test_trailing_whitespace_success(self):
        res = validators.trailing_whitespace(TestValidators.TRAILING_WHITESPACE_SUCCESS)
        self.assertIsNone(res)
