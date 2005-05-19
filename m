From: komoriya@paken.org (Takeru KOMORIYA)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: [PATCH] updated it87 for kernel 2.6 - Part1
Message-Id: <20040218081607.06eb8ef4.komoriya@paken.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040216231514.61a84c5e.komoriya@paken.org>
In-Reply-To: <20040216231514.61a84c5e.komoriya@paken.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 17 Feb 2004 10:01:54 +0100
Jean Delvare <khali@linux-fr.org> wrote:

> > I agree with you. I was feeling something strange with INVALID.
> > I think it's better to change "invalid" in sensors program(patch
> > is attached).
> 
> Correct, except that now, a really invalid value (i.e. different
> from 0,
> 2 and 3) will be silently ignored. I agree that, if the driver is
> written correctly, this should not possibly happen. Still, an extra
> check doesn't cost much and could help us trap problems later. I'll
> correct this.

Thanks.

> > Also, documentation for it87 should be changed.
> > -----
> >   To change sensor x to a thermistor, 'echo 2 > sensorx'
> >   where x is 1, 2, or 3.
> >   To change sensor x to a thermal diode, 'echo 3 > sensorx'.
> > - Any other value is invalid.
> > + Give 0 for unused sensor.
> > ----
> 
> Correct again, except that "Any other value is invalid" should be
> kept. I'll handle that too.

Thanks again.

> > Oh, I was in confusion! Sorry for my rush patch.
> > Please just ingore my first patch which contains useless code.
> 
> I guess you refer to the additional chunk in it87_update_client? I
> don't
> really get why you say it is useless. I would keep that code. Our
> general policy is not to do any supposition as to wether some values
> don't change in chips (such as limits, and in this case sensor
> types). We have seen cases where these "constant" values *were*
> changing, probably because the BIOS is accessing the chip in our
> back. So, reading the sensor types in it87_update_client sounds like
> the right thing to do (although I agree that in most case it should
> be safe not to do so).

I think I understand what you say. We should handle all register
values as "volatile". I feel it's reasonable.
I added the code for updating sensor types into it87_update_client.

> I still would like set_sensor to fail (return -1) if an attempt to
> write an invalid value (i.e. different from 0, 2 and 3) is made.
> This basically means adding the following lines:
> 
> 	if (val = 3)
> 	    data->sensor |= 1 << nr;
> 	else if (val = 2)
> 	    data->sensor |= 8 << nr;
> +	else if (val != 0)
> +	    return -1;
> 
> Unless you have an objection, of course.

OK, I agree with definition that the values other than 0,2,3 are
invalid value. 

Here's new patch with this mail. Please check it.

Thanks in advance.
-----------------------
Takeru Komoriya
 komoriya@paken.org
 http://www.paken.org/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: linux-2.6.2-rc2_it87_sensor_type.patch
Type: application/octet-stream
Size: 2204 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040218/52bbf8bf/linux-2.6.2-rc2_it87_sensor_type.obj
