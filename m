From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 15 Jul 2005 19:35:57 +0000
Subject: [lm-sensors] Added sysfs support for decode-dimms.pl
Message-Id: <20050715193525.27a18349.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
In-Reply-To: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Burkart,

> I modified the code for decode-dimms.pl as you suggested. Now only the
> first 128 bytes of the SPD EEPROM are read, moreover this is done in
> a central sub routine rather than at 8 different places in the code.
> The bank number guessing is now also working with the sysfs.
> 
> The new version can be found at http://www.bollchen.de/decode-dimms.pl
> and the output of diff -u is located at
> http://www.bollchen.de/diff.out
> 
> Let me know what you think.

I finally took some time to commit your changes. Sorry for the delay. I
additionally refactored the code as I had previously suggested, and
fixed a few other things. The new version of the script is in lm_sensors
CVS now, so the upcoming 2.9.2 release will have it. Feel tree to test
that it still works OK for you:

  http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/prog/eeprom/decode-dimms.pl

Vielen Dank f?r deine gute Arbeit :)

-- 
Jean Delvare
