From: awolfego@telusplanet.net (Adam Wolfe Gordon)
Date: Thu, 19 May 2005 06:24:45 +0000
Subject: Support ticket #1593
Message-Id: <790000.1078182607@[192.168.1.3]>
List-Id: <lm-sensors.vger.kernel.org>
References: <1000000.1078109984@[192.168.1.3]>
In-Reply-To: <1000000.1078109984@[192.168.1.3]>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'll try the CVS version, but I'm not sure that that is the problem.  I had 
lm_sensors working on this computer before I upgraded to SuSE 9.0 from SuSE 
8.2, and at that point I remember that it was a w83781d chip.  I have an 
Asus A7N8X-X, so that is what it's upposed to have.  I'll try the it87 
though, and let you know how it works.

Thanks!

---------- On Monday, March 01, 2004 11:46:43 AM +0100, Jean Delvare 
<khali@linux-fr.org> wrote: ----------
> [Please reply to the list, not to me]
>
> Quoting Adam Wolfe Gordon <awolfego@telusplanet.net>:
>
>> Here is the output of sensors-detect:
>> (...)
>> Client found at address 0x2d
>> (...)
>> Client found at address 0x2f
>> (...)
>> Client found at address 0x48
>> (...)
>> Client found at address 0x49
>> (...)
>> Client found at address 0x4b
>
> You do have many unrecognized chips. Dumps would help identifying them,
> but see below.
>
>> Some Super I/O chips may also contain sensors. Super I/O probes
>> are typically a bit more dangerous, as we have to write to I/O
>> ports to do this.  Do you want to scan for Super I/O sensors?
>> (YES/no):
>> Probing for `SMSC 47M1xx Super IO Fan Sensors'
>>   Failed! (0x87)
>> Probing for `VT1211 Super IO Sensors'
>>   Failed! (0x87)
>> Probing for `Winbond W83627HF Super IO Sensors'
>>   Failed! (0x87)
>> Probing for `Winbond W83627THF Super IO Sensors'
>>   Failed! (0x87)
>> Probing for `Winbond W83697HF Super IO Sensors'
>>   Failed! (0x87)
>
> Most likely you do have an ITE it87xx chipset. Recent versions of
> sensors-detect may have found it. I guess you are using an old one.
>
> Please get lm_sensors CVS and install the user-space tools (make user &&
> make user_install). Try the new sensors-detect, it should find an it87
> chip, and possibly more. The new Super-I/O detection code is one day
> old, you're our first tester ;)
>
> For all addresses listed above for which the latest version of
> sensors-detect did not find anything, you can provide a dump (i2cdump 1
> 0xNN, where NN is each chip address) for analysis. These addresses are
> usual for hardware monitoring chips, so they could be new ones we don't
> support yet.
>
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/
>

---------- End Quoted Message ----------


----------
Adam Wolfe Gordon
Email: awolfego@telusplanet.net
Public Key: http://www3.telus.net/awolfego
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040301/14c69abb/attachment.bin
