From: Peter.Milne@d-tacq.com (Peter Milne)
Date: Sun, 18 Jun 2006 21:28:26 +0000
Subject: [lm-sensors] PATCH- i2c-iop3xx platform driver avoid addressing
Message-Id: <4495C57A.6010703@d-tacq.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44931779.6050302@d-tacq.com>
In-Reply-To: <44931779.6050302@d-tacq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean

Jean Delvare wrote:
<snip>

>>OK, new patch leaves the slave address at default 0.
>>    
>>
>
>Huh, this might be worst :/ 0 is the "general call address", think of
>it as a broadcast address. 2 is reserved for "CBUS compatibility"
>(whatever it is.)
>  
>
Sorry, I should have explained before, there is a bit set in the control 
register: IOP3XX_ICR_GCD - this according to the manual "disables i2c 
unit response to general call messages as a slave".

So it really shouldn't respond to an external master making a General 
Call, the issue I'm trying to avoid is the problem of addressing itself.

>I would suggest 8, which is the "SMBus host" address in the SMBus spec
>- unless you have to deal with multi-master busses where this address
>might be already taken by another master.
>
>Note that I have no strong opinion on this either, as long as nothing
>breaks and you are happy...
>  
>
Prefer to stick with zero, thanks, it works. I don't think anyone uses 
this device as a slave, but if they did, it would be easy to configure a 
valid address.

>  
>
>>I note that i2cdetect now scans from 0x3, but I'd still prefer to 
>>prevent writes to the device's own address since this wedges the unit.
>>    
>>
>
>Sure, I have no problem with this.
>
>  
>
>>@@ -243,12 +240,19 @@ iop3xx_i2c_wait_idle(struct i2c_algo_iop
>> 
>> static int 
>> iop3xx_i2c_send_target_addr(struct i2c_algo_iop3xx_data *iop3xx_adap, 
>>-				struct i2c_msg* msg)
>>+			    struct i2c_msg* msg)
>> {
>>    
>>
>
>Please don't mix cleanups with real changes!
>  
>
fixed in patch -

>  
>
>> 	unsigned long cr = __raw_readl(iop3xx_adap->ioaddr + CR_OFFSET);
>> 	int status;
>> 	int rc;
>> 
>>+	/* avoid writing to my slave address (hangs on 80331),
>>+	 * forbidden in Intel developer manual
>>+	 */
>>+	if (msg->addr = MYSAR) {
>>+		return -I2C_ERR_WRITEMYSAR;
>>+	}
>>+	
>>    
>>
>
>How will the address be reported by i2cdetect? As if there was no chip
>there, I guess (XX)? 
>
At zero, comes out as "XX" on the "old" i2cdetect, skipped in the new one.

>I'm a bit worried about this, as someone might
>then want to use the address for something else without realizing that
>the address is already in use. Would it be possible to make it so that
>the address would be reported as busy (UU)? I'm not too sure myself if
>the i2c-core currently allows this, but I'd like you to investigate in
>that direction as it might avoid trouble in the future. I guess the
>only way right now would be to instanciante a fake client at that
>address.
>  
>
The routine now returns -EBUSY, but i2cdetect still reports "XX". When I 
address it with another low level utility, it reports:
"Device or resource busy" - which is fair enough, the device is busy 
being a master so it cannot simultaneously be a slave ...

Maybe Intel knew what they were doing when they set 0 as the default 
slave address.
Because nobody is going to choose that as a real slave address, are they 
:-).

So, are we there with this patch now?

Thanks


Peter.

-- 
Peter Milne			Peter.Milne at d-tacq.com
D-TACQ Solutions Ltd		www.d-tacq.com

-------------- next part --------------
A non-text attachment was scrubbed...
Name: i2c-iop3xx.3.patch
Type: text/x-patch
Size: 2071 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060618/078c5765/attachment.bin 
