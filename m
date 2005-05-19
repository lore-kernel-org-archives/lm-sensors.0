From: rafael.espindola@gmail.com (=?ISO-8859-1?Q?Rafael_Esp=EDndola?=)
Date: Thu, 19 May 2005 06:25:40 +0000
Subject: emc6d102 support
Message-Id: <564d96fb0502260719330f222a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502011003.40803.rafael.espindola@gmail.com>
In-Reply-To: <200502011003.40803.rafael.espindola@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 24 Feb 2005 01:08:57 -0800, Philip Pokorny
<ppokorny@penguincomputing.com> wrote:
> I have some comments...
 
> Why did you remove the definition of EXTEND_ADC2?  It's not used by
> name, but it's there to document the registers that are used by the driver.
ok. I added it back.

> Hmmm..   The EMC6D102 datasheet shows these registers (0x70 - 0x78) as
> "test registers" that are "reserved".
> 
> http://www.smsc.com/main/datasheets/6d102.pdf
> 
> We should add addtional code to prevent reading or setting the
> additional in5, in6 and in7 inputs if the chip is an emc6d102.
It is already there. These registers are read only if (data->type = emc6d100)

> I think I'd leave those on one line so a 'grep' for the function would
> pick out the definition as well as the function name.  But that's just
> me.  Perhaps there is some applicable style guideline?
Those macro definitions had more then 80 columns.

> Given the additional complexity introduced by the possibility of
> different scaling factors (4 for adm1027, 16 for EMC6D102) I think I
> would change this from a u16 to a *decoded* value in two arrays:
> 
>     u8  temp_ext[3];             /* Decoded values */
>     u8  in_ext[8];               /* Decoded values */
>     u8  adc_scale;               /* ADC Extended bits scaling factor */
> 
> Then put all the shift and mask code in 'lm85_update_device' and have it
> read the values and break them up into the appropriate '_ext[]' values.
> That's a simple loop for the adm1027 where the bits are in the same
> order as the sensors.  It's a bit more complicated in the case of the
> EMC6D102 because things are moved around a bit, but I think it would
> make more sense for that code to be in '_update_device'.
> 
> Then set adc_scale appropriately at initial detection time.
Did it. The resulting code is indeed simpler.

> for example.  It might even make sense to just pass 'data' to the
> '???EXT_FROM_REG()' macro and let it dereference the structure pointer...
I fill a bit uncomfortable with big macros...

> I don't see any comment about the time ordering of reading the LSB's and
> the MSB's.  The data sheet says that reading the upper 8-bit MSB's latch
> the corresponding lower 4 bit LSB's.  You'll note that this is
> *backward* from the ADM1027 where the LSB need to be read *first* to
> latch the MSB's.
> 
> A note regarding this difference should be included in comments for the
> code to read the EMC6D102 extended bits.
Added one. 

Thanks for the comments.
The resulting patch is attached.
Rafael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: emc6d102-kernel.patch
Type: application/octet-stream
Size: 7525 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050226/89c1c04b/emc6d102-kernel.obj
