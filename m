From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Wed, 02 Nov 2005 12:22:55 +0000
Subject: [lm-sensors] New Abit uGuru driver + libsensors patch, review
Message-Id: <4368A192.9000407@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <4358B291.6070702@hhs.nl>
In-Reply-To: <4358B291.6070702@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 
> That is most likely the case with the uGuru (I know I would have read
> protected it). We could try to get the code out of a firmware update,
> but there don't seem to be any firmware updates, the bios updates use a
> standard awardflash program which (AFAIK) is not aware of the uGuru chip
> and the size of the bios updates also is a power of 2, which makes it
> unlikely that they also contain firmware for the uGuru.

I think this can be part of BIOS image. I can try to expand the image and examine the files inside
do you know any "classical" byte sequence of microchip 051 opcodes?

I looked to the winbond datasheet and it seems they provide a way to read the flash.
I did not check if this can be disabled on the other hand...

>> This is not what makes us happy. We simply need SAME interface for
>> every possible chip that provides voltages. We dont
>> want any "if uguru" in software libraries.

> 
> I guess that didn't come out as I intended it, sorry. I agree that the
> interface exported to userspace should be identical for all sensors. I
> was / am actually surprised by the chips.c stuff in lib-sensors  +
> sensors-app, I had expected all the chip specifics to be either in the
> kernel driver or sensors.conf.

I agree that the library is ungly, there is a plan to replace it with better one and that is the reason we
need well defined interface.

> I'll modify the driver to scale all register values to 0-3.5V this is
> correct for most inputs, the other non standard inputs will have to be
> handled in sensors.conf.

OK thanks

Regards
Rudolf
