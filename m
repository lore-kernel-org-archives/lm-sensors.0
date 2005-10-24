From: david.goodenough@btconnect.com (David Goodenough)
Date: Mon, 24 Oct 2005 11:52:25 +0000
Subject: [lm-sensors] ATI SMBus - new information
Message-Id: <200510241051.00183.david.goodenough@btconnect.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <435A1BA9.9080009@sh.cvut.cz>
In-Reply-To: <435A1BA9.9080009@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf,

I am not quite sure why I am included in the CC list for this note.  I do not 
have one of these chips on my system as far as I know, the only only
ATI chip I have is a Radeon video chip.

David

On Saturday 22 October 2005 21:12, Rudolf Marek wrote:
> Hello all,
>
> Update. Please send me the DSDT tables directly. The mailing list will
> throw them away.(bin attachment) See the attachment for the patch.
>
> Please note, the code was not tested. I belive it should work, but it may
> do bad things to your HW. On the other hand you want the ATI SMBUS support
> :)
>
> This patch is for 2.6 driver of i2c-i801.c After applying the patch you
> should be able to modprobe i2c-i801 if you modprobe i2c-dev then you should
> be able to run i2cdetect and i2cdump.
>
> i2cdump 0
> should show that 0x50 or above is used.
>
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: 50 51 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
>
> If you see all XX it means there is nothing or my patch does not work.
>
> If so you can try to dump the address:
> i2cdump 0 0x50
>
> 00: 80 08 07 0d 0a 02 40 00 04 50 60 00 82 08 00 01    ??????@.?P`.??.?
> 10: 0e 04 0c 01 02 20 00 60 70 00 00 3c 28 3c 28 40    ????? .`p..<(<(@
>
> ....
>
> If the output is similar to this one then you can run sensors-detect to
> detect the chips (leave the i2c-i801 loaded)
>
> Please report how it goes.
> Good luck.
>
> Thanks,
> Regards
> Rudolf
