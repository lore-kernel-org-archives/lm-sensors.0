From: whitney@Math.Berkeley.EDU (Wayne Whitney)
Date: Thu, 19 May 2005 06:24:27 +0000
Subject: lm_sensors current CVS on 2.6.0-test10
Message-Id: <Pine.SOL.4.44.0311261657140.26419-100000@blue1>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm running 2.6.0-test10 with Fedora Core 1 userspace, and I compiled the
userspace lm_sensors programs from current CVS.  I find that whenever I
run sensors, after it finishes executing correctly, it segfaults.
Running 'gdb sensors' shows the following on exit:

Program received signal SIGSEGV, Segmentation fault.
0x009402bc in _int_free () from /lib/tls/libc.so.6

I assume this means some sort of bad interaction with the thread library
in Fedora Core 1, but that's the extent of my understanding.  What should
I do?

Thanks,
Wayne

