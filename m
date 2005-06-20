From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 20 Jun 2005 22:50:52 +0000
Subject: [lm-sensors] Added sysfs support for decode-dimms.pl
Message-Id: <20050620225047.622c4b10.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
In-Reply-To: <000201c571f9$ac2fb410$4d01a8c0@BURKART>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hallo Burkart,

> I modified the code for decode-dimms.pl as you suggested. Now only the
> first  128 bytes of the SPD EEPROM are read, moreover this is done in
> a central sub  routine rather than at 8 different places in the code.
> The bank number  guessing is now also working with the sysfs.
> 
> The new version can be found at http://www.bollchen.de/decode-dimms.pl
> and  the output of diff -u is located at
> http://www.bollchen.de/diff.out
> 
> Let me know what you think.

It's much better, but I think we can do even better:

1*

		# Kernel 2.4 with procfs
		if ($offset = 0) {		# bytes 0..15
			$_=`cat /proc/sys/dev/sensors/$dimm_i/00`;
		} elsif ($offset = 16) {	# bytes 16..31
			$_=`cat /proc/sys/dev/sensors/$dimm_i/10`;
		} elsif ($offset = 32) {	# bytes 32..47
			$_=`cat /proc/sys/dev/sensors/$dimm_i/20`;
		} elsif ($offset = 48) {	# bytes 48..63
			$_=`cat /proc/sys/dev/sensors/$dimm_i/30`;
		} elsif ($offset = 64) {	# bytes 64..79
			$_=`cat /proc/sys/dev/sensors/$dimm_i/40`;
		} elsif ($offset = 80) {	# bytes 80..95
			$_=`cat /proc/sys/dev/sensors/$dimm_i/50`;
		} elsif ($offset = 96) {	# bytes 96..111
			$_=`cat /proc/sys/dev/sensors/$dimm_i/60`;
		} elsif ($offset = 112) {	# bytes 112..127
			$_=`cat /proc/sys/dev/sensors/$dimm_i/70`;
		} else {			# illegal offset
			$_='255 'x15 . '255';
		}

This is slow and inefficient. What about:

$offset=sprintf('%02x', $offset);
$_=`cat /proc/sys/dev/sensors/$dimm_i/$offset`

2* In various places you are doing:
if (-e "/sys/bus/i2c/drivers/eeprom")
to test if sysfs is used or not.

I think you could check for /sys/bus at the very beginning of the
script, and have a global variable $use_sysfs. So you would only have to
check for that variable in the rest of the script. I think it would make
the code much clearer.

Other than that it looks OK, except that your patch changes whitespace
in various places, making the patch look much bigger than it actually
is. I suspect that your editor strips whitespace at end of lines or
something like that... Not a big deal though.

Thanks,
-- 
Jean Delvare
