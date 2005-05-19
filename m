From: morris@wolfman.com (Jim Morris)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: lm_sensors2/prog/detect sensors-detect
Message-Id: <200306271442.50867.morris@wolfman.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021107235845.0037e195.khali@linux-fr.org>
In-Reply-To: <20021107235845.0037e195.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Friday 27 June 2003 02:22 pm, you wrote:
>
> Could be... But there is one last thing I would like to try. My changes
> (-k3) don't seem to have had any effect, so I'm trying something similar
> but different. Please get
>   http://www.ensicaen.ismra.fr/~delvare/sensors-detect-k4
> and tell me, again, it it behaves differently with and without an UTF-8
> locale.

That seemed to fix it!!!

without UTF8......

Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290...
Called inb with porte7
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with porte8
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with porte9
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with portf3
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with portf1
After sysseek
After sysread, nrchars=1
Read value with ordy
Returning resy

Called inb with portf1
After sysseek
After sysread, nrchars=1
Read value with ord6
Returning res6

Called inb with portf2
After sysseek
After sysread, nrchars=1
Read value with ord
Returning res

Called inb with portf2
After sysseek
After sysread, nrchars=1
Read value with ord4
Returning res4
Success!
    (confidence 8, driver `it87')
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0...
Called inb with port235
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5
Failed!

========================with UTF8
Probing for `ITE IT8705F / IT8712F / SiS 950'
  Trying address 0x0290...
Called inb with porte7
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with porte8
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with porte9
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with portf3
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5

Called inb with portf1
After sysseek
After sysread, nrchars=1
Read value with ordy
Returning resy

Called inb with portf1
After sysseek
After sysread, nrchars=1
Read value with ord6
Returning res6

Called inb with portf2
After sysseek
After sysread, nrchars=1
Read value with ord
Returning res

Called inb with portf2
After sysseek
After sysread, nrchars=1
Read value with ord4
Returning res4
Success!
    (confidence 8, driver `it87')
Probing for `IPMI BMC KCS'
  Trying address 0x0ca0...
Called inb with port235
After sysseek
After sysread, nrchars=1
Read value with ord%5
Returning res%5
Failed!


