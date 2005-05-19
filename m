From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: RFC: complete rewrite of i2c-i801 for 2.6.x
Message-Id: <Gjci285V.1102499921.2180000.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041128193640.GB5855@jupiter.solarsys.private>
In-Reply-To: <20041128193640.GB5855@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Mark,

> Interesting.  It looks like that datasheet only shows this:
>
>	S Addr Wr [A] Comm [A] D0 [A] D1 [A] S (read bytes...)
>
> I agree that's not like any transaction we support.

True. Not only that but it seems that this function is broken at least in
the ICH3-M (which I have). The specification update from Intel [1] says
so.

> OTOH, the ICH5 [1] datasheet shows this:
>
>	S Addr Wr [A] D1 [A] S (read bytes...)
>
> That's exactly the transfer protocol that eeproms need, right?  (That's why
> I mentioned to Khali by IRC last weekend that I thought it should be
> possible.)

True again.

> It would be really bizarre if these two chipsets behaved differently in
> this respect - I wonder if the datasheets are correct?

I think they are. Intel are very serious with datasheets. I believe they
implemented a useless function, realized that and simply changed it in
the newer revisions of the ICH. BTW it would certainly be worth looking
at the revision numbers of our chips. The revision is shown by lspci
(aming others). Mine is 01. I would expect a different value for the
chips with the new I2C block read function. If I'm right, that would be
a convenient detection method.

I will not try the weird I2C block read on my system since it really
starts like a write command and I wouldn't want to trash my eeproms
accidentally.

> [1] Well I just scanned all the other datasheets... only ICH5, ICH6, and
> 6300ESB appear to support the standard I2C block read.  Sorry Khali. :)

Yes, it looks so. I guess I'll have to change my laptop for an
ICH6-based one then ;)

However, what I had in mind was NOT to use that weird function but to
hi-jack the SMBus block read command. Unless I am mistaken, the only
difference between SMBus and I2C block reads is that the former has an
additional leading (read) byte for the length while the latter doesn't.
My plan was to implement I2C block reads using the SMBus block read. All
I'd need to do is copy the supposed length byte as the first data byte
and shift all other data bytes by one position. Sounds simple... except
that it doesn't seem to work. Or, more precisely, sometimes it works
and sometimes is doesn't. Seems to depend on the first byte read. I
suppose that the ICH3-M trusts this byte more than the LAST_BYTE bit
(the specification update confirms that this is the case for the weird
I2C block read function, making it useless as I said earlier). I tried
to overwrite the byte length with 32 after the first transfer of the
block but it didn't seem to help. Also, I see no relation between the
value of the first byte and the point at which the block read dies on a
timeout, although this is perfectly reproducible.

I'll investigate again this evening but with little hope. And anyway
this sounds like a trick we might not want to implement in the released
driver even if it somewhat works, especially since I2C block reads are
really only a bonus for EEPROMs, not a vital feature for hardware
monitoring.

[1] http://www.intel.com/design/chipsets/specupdt/290718.htm

Thanks,
--
Jean Delvare
