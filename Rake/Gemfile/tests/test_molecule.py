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

from molecule.core import Molecule

from mock import patch


class TestStringMethods(testtools.TestCase):

    OUTPUT_MIXED_FAILED = """
    TASK: [cisco.zuul | Adjust setup script] **************************************
    ok: [aio-01-ubuntu]

    TASK: [cisco.zuul | file ] ****************************************************
    changed: [aio-01-ubuntu]

    TASK: [cisco.zuul | Fetch Zuul portal dependencies] ***************************
    ok: [aio-01-ubuntu]

    TASK: [cisco.zuul | start zuul service] ***************************************
    changed: [aio-01-ubuntu]

    TASK: [cisco.zuul | start zuul merger service] ********************************
    changed: [aio-01-ubuntu]

    NOTIFIED: [cisco.zuul | restart apache2] **************************************
    changed: [aio-01-ubuntu]

    PLAY RECAP ********************************************************************
    aio-01-ubuntu              : ok=36   changed=29   unreachable=0    failed=0
    """

    OUTPUT_MIXED_SUCCESS = """
    TASK: [cisco.zuul | Adjust setup script] **************************************
    ok: [aio-01-ubuntu]

    TASK: [cisco.zuul | Fetch Zuul portal dependencies] ***************************
    ok: [aio-01-ubuntu]

    NOTIFIED: [cisco.zuul | restart apache2] **************************************
    changed: [aio-01-ubuntu]

    PLAY RECAP ********************************************************************
    aio-01-ubuntu              : ok=36   changed=0    unreachable=0    failed=0
    """

    def setUp(self):
        super(TestStringMethods, self).setUp()
        with patch('molecule.core.Molecule._main') as mocked:
            mocked.return_value = None
            self.molecule = Molecule(None)

    def test_parse_provisioning_output_failure_00(self):
        res = self.molecule._parse_provisioning_output(TestStringMethods.OUTPUT_MIXED_FAILED)
        self.assertFalse(res)

    def test_parse_provisioning_output_success_00(self):
        res = self.molecule._parse_provisioning_output(TestStringMethods.OUTPUT_MIXED_SUCCESS)
        self.assertTrue(res)
