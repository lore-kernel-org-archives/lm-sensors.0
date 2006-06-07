From: david.c.hubbard@gmail.com (David Hubbard)
Date: Wed, 07 Jun 2006 20:51:52 +0000
Subject: [lm-sensors] [PATCH] W83627EHF driver update
Message-Id: <4dfa50520606071351x3d0a2214iba829b73fd832c33@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4485CB7A.9050209@sh.cvut.cz>
In-Reply-To: <4485CB7A.9050209@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I like the added mutex locking. It's a good idea. It sounds like
you'll be modifying it a little?

Here is the output of the regression test on my machine:
# ./w83627ehf_regression.sh
* WARNING: This will run your system fans through many possible
           combinations. There is a possibility your system will
           overheat. Use this script at your own risk!
Mapping fans...setting all PWMs to 100%
    fan 1 0 RPM: ignored. (Fan not installed?)
    fan 2 0 RPM: ignored. (Fan not installed?)
    fan 3 3479 RPM:
        pwm1 3443 RPM
        pwm2 3443 RPM
        pwm3 1654 RPM: connected.
Testing fan 3 - pwm3 ... div OK, PWM/DC OK, enable OK
test_smartfan1 $1="3" $2="pwm3"
, SF1 OK

Obviously, I'm right in the middle of building SmartFan 1 testing. It
doesn't test that. Everything else works fine. I'm attaching the
regression test which is updated for this patch. So, sign me off on
it.

Thanks,
David
-------------- next part --------------
A non-text attachment was scrubbed...
Name: w83627ehf_regression.sh
Type: application/x-sh
Size: 15366 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060607/ba81aba3/attachment.sh 
