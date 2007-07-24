From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Tue, 24 Jul 2007 14:40:08 +0000
Subject: Re: [lm-sensors] Fujitsu-Siemens Scylla (fscscy)
Message-Id: <46A60F48.7080309@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46933578.3010701@miloi.de>
In-Reply-To: <46933578.3010701@miloi.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Mon, 23 Jul 2007 16:33:12 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> Hi Hans,
>>>
>>> You may also want to take a look at the pending driver for the new FSC
>>> Heimdall chip:
>>> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-January/018629.html
>>> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-February/018787.html
>>> I wonder if it is also similar. I just added an entry to wiki/Devices.
>> It is indeed similar too, for some reason FSC keeps changes fan and temp 
>> register addresses, but that can easily be handled with an array addressed with 
>> the chip-type.
> 
> It depends on how different they are, but in general, different
> register maps is the reason #1 for writing different drivers.
> 

I understand, but in this case a simple 2d lookup table addressed with the 
chiptype and sensor number is all thats needed as the contents of the registers 
haven't changed (same scaling / same bits used in status registers), for some 
reason FSC has just shuffled them around a bit, and then really only a bit, 
just enough to make the lookup tabel the easiest solution, see below.

>> Also they seem to have done strange things with temp sensor numbers, for the 
>> fscpos and fscher the temp sensors are identical, however the fscscy adds a 
>> fourth sensor, but in the 2.4 sensors puts that in as temp2 moving temp2 and 3 
>> to temp3 and 4 when compared to the fscher / fscpos, I guess its best to just 
>> clone this erm "interesting" numbering in the 2.6 driver.
> 
> If you're going for a new driver, and it makes it easier to number them
> differently, go for it.
> 

Well, for example lets look at the fan registers, here is what my WIP has for 
them now:

static const u8 FSCPOS_REG_FAN_MIN[4][6] = {
	{ 0x55, 0x65 },					/* pos */
	{ 0x55, 0x65, 0xb5 },				/* her */
	{ 0x65, 0x65, 0x55, 0xa5, 0x55, 0xa5 },		/* scy */
	{ 0x55, 0x65, 0xa5, 0xb5, 0xc5 } };		/* hmd */

/* actual fan speed */	
static const u8 FSCPOS_REG_FAN_ACT[4][6] = {
	{ 0x0e, 0x6b, 0xab },				/* pos */
	{ 0x0e, 0x6b, 0xbb },				/* her */
	{ 0x6b, 0x6c, 0x0e, 0xab, 0x5c, 0xbb },		/* scy */
	{ 0x5b, 0x6b, 0xab, 0xbb, 0xcb } };		/* hmd */

/* fan status registers */
static const u8 FSCPOS_REG_FAN_STATE[4][6] = {
	{ 0x0d, 0x62, 0xa2 },				/* pos */
	{ 0x0d, 0x62, 0xb2 },				/* her */
	{ 0x62, 0x61, 0x0d, 0xa2, 0x52, 0xb2 },		/* scy */
	{ 0x52, 0x62, 0xa2, 0xb2, 0xc2 } };		/* hmd */
	
/* fan ripple / divider registers */	
static const u8 FSCPOS_REG_FAN_RIPPLE[] = {
	{ 0x0f, 0x6f, 0xaf },				/* pos */
	{ 0x0f, 0x6f, 0xbf },				/* her */
	{ 0x6f, 0x6f, 0x0f, 0xaf, 0x0f, 0xbf },		/* scy */
	{ 0x5f, 0x6f, 0xaf, 0xbf, 0xcf } };		/* hmd */

And when I reshuffle the scy to match the pos and her you get:

static const u8 FSCPOS_REG_FAN_MIN[4][6] = {
	{ 0x55, 0x65 },					/* pos */
	{ 0x55, 0x65, 0xb5 },				/* her */
	{ 0x55, 0x65, 0xa5, 0x65, 0x55, 0xa5 },		/* scy */
	{ 0x55, 0x65, 0xa5, 0xb5, 0xc5 } };		/* hmd */

/* actual fan speed */	
static const u8 FSCPOS_REG_FAN_ACT[4][6] = {
	{ 0x0e, 0x6b, 0xab },				/* pos */
	{ 0x0e, 0x6b, 0xbb },				/* her */
	{ 0x0e, 0x6b, 0xab, 0x6c, 0x5c, 0xbb },		/* scy */
	{ 0x5b, 0x6b, 0xab, 0xbb, 0xcb } };		/* hmd */

/* fan status registers */
static const u8 FSCPOS_REG_FAN_STATE[4][6] = {
	{ 0x0d, 0x62, 0xa2 },				/* pos */
	{ 0x0d, 0x62, 0xb2 },				/* her */
	{ 0x0d, 0x62, 0xa2, 0x61, 0x52, 0xb2 },		/* scy */
	{ 0x52, 0x62, 0xa2, 0xb2, 0xc2 } };		/* hmd */
	
/* fan ripple / divider registers */	
static const u8 FSCPOS_REG_FAN_RIPPLE[] = {
	{ 0x0f, 0x6f, 0xaf },				/* pos */
	{ 0x0f, 0x6f, 0xbf },				/* her */
	{ 0x0f, 0x6f, 0xaf, 0x6f, 0x0f, 0xbf },		/* scy */
	{ 0x5f, 0x6f, 0xaf, 0xbf, 0xcf } };		/* hmd */

Notice that for the first 3 fans, all chips are almost identical. Thr only 
differences are that the hmd uses 0x5* instead of 0x0* for the 3 of the 4 fan1 
registers and that the fscher uses 0xb* instead of 0xa*. Also the 4th and 5th 
fan of the scy and hmd are much more different from one another.

To me the almost the same and same register contents warrents using a unified 
driver, especially since for example the voltage registers are on the same 
place for all. However taking all these smalle register map differences 
together, the easiest path for a unified driver is to use the lookup tables 
above, and once the lookup tables are there, its really easy to keep the order 
of the sensors in the fscscy as with the 2.4 driver. Let me know if you prefer 
the hussled order, as that does make it clearer that they are one and the same 
family of chips.

>>> * I discourage the use of "x" in the driver names. It looks great only
>>> until the day a new chip is released, those name matches the mask, but
>>> which isn't compatible at all. For hardware monitoring drivers, we tend
>>> to name the driver after the first supported chip, and consider the
>>> others as "mostly foo-compatible."
>> Okay, so I will call it fscpos_new then.
> 
> If you're going to include Scylla support in it, it might make sense to
> name it fscscy instead, as this driver doesn't yet exist in 2.6, this
> will save us the pain of renaming the driver at a later date.
> 

Good idea, I'll do that.

> In general, I suggest that you avoid pushing in the kernel support for
> random chips which are not known to be in use in real-world hardware.
> Even if you maintain them yourself, you won't do it forever, and having
> unused drivers only slows things down and lower the average quality. So
> better pick chips from the Devices page where at least one user
> requested support already (as the ADM1024, ADT7475/76, F75387SG/RG or
> MAX6648/92.)
> 

Good point, I fully agree and thanks for the input. I haven't checked all the 
links on the device wiki yet, will do, but you don't happen to know motherboard 
models which come with these chips do you? Or even better have a spare one you 
can miss (I have a small budget for the labs, so I can pay for shipping + 
something extra).

> If your 1st year students learn how to write drivers, maybe in 2nd year
> you can teach them how to review drivers? ;) That's what we need the
> most.

Erm, they are 4th year students, but if the want to stay another year I can try :)

Thanks & Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
