From: burkart.lingner@gmx.de (Burkart Lingner)
Date: Mon, 20 Jun 2005 17:05:01 +0000
Subject: [lm-sensors] Added sysfs support for decode-dimms.pl
Message-Id: <000301c575a9$88ddd790$4d01a8c0@BURKART>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
In-Reply-To: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Salut, Jean!

I modified the code for decode-dimms.pl as you suggested. Now only the first 
128 bytes of the SPD EEPROM are read, moreover this is done in a central sub 
routine rather than at 8 different places in the code. The bank number 
guessing is now also working with the sysfs.

The new version can be found at http://www.bollchen.de/decode-dimms.pl and 
the output of diff -u is located at http://www.bollchen.de/diff.out

Let me know what you think.
Bye, Burkart 

