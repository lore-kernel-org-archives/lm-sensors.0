From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 09 Aug 2005 21:29:20 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: Rewrite i2c_probe
Message-Id: <20050809212913.18dfad54.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050809201755.15962b81.khali@linux-fr.org>
In-Reply-To: <20050809201755.15962b81.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> Good thing you brought this up. This is a site of a problem I see.
> I snipped all but a particular line in source you are posting so you
> can see.
> 
> As you can see in the below code, the call to i2c_smbus_xfer() has
> I2C_SMBUS_QUICK in the 2nd to last parameter.
> Looking at the definition of i2c_smbus_xfer(), we see that the
> parameters are:
> extern s32 i2c_smbus_xfer (struct i2c_adapter * adapter, u16 addr,
>                            unsigned short flags,
>                            char read_write, u8 command, int size,
>                            union i2c_smbus_data * data);
> 
> As the code below shows, the 3rd to last should be I2C_SMBUS_QUICK. Is
> this an accurate assumption?

No, it's not. The code looks correct to me.

> If not, can you please explain this? I have seen this problem pretty
> much everywhere i2c_smbus_xfer() and i2c_smbus_xfer_emulated() are
> called.

"size" refers to the type of SMBus transaction that is being performed.
These are refered to as "protocols" in the SMBus 2.0 specification (page
26, 5.3):

"There are eleven possible command protocols for any given device. A
slave device may use any or all of the eleven protocols to communicate.
The protocols are Quick Command, Send Byte, Receive Byte, Write Byte,
Write Word, Read Byte, Read Word, Process Call, Block Read, Block Write
and Block Write-Block Read Process Call."

I think that the "size" term comes from the fact that the seven
fundamental "protocols" have an increasing data size: quick command has
0 data byte, send/receive byte have 1, write/read byte have 2 and
write/read word have 3. I agree that this is somewhat of a misnommer,
but it ain't that bad when you know what it is all about, and I wouldn't
like "protocol" much better.

"command" refers to the first data byte being transfered after the
address+write byte. If I remember correctly, all "protocols" except
Quick Command and Receive Byte start with a command byte. So please note
that the "0" value for the command parameter in our example doesn't mean
anything, it's not used at all. From the SMBus 2.0, same page and
section as above:

"A typical SMBus device will have a set of commands by which data can be
read and written. All commands are 8 bits (1 byte) long. Command
arguments and return values can vary in length."

> If this is a semantic bug, I will be glad to patch this today.

This is a semantic issue, but I wouldn't call it a bug. I don't think
the "command" and "size" names are as bad as you claim. Especially
"command" is taken from the SMBus specification itself. I see no
immediate need to change the parameter names, as it would possibly
confuse people more than help them. You are the first one to complain
about these names since I started working on i2c/lm_sensors, two years
ago.

Thanks,
-- 
Jean Delvare
