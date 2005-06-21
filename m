From: x0nishan@ti.com (Menon, Nishanth)
Date: Tue, 21 Jun 2005 17:52:58 +0000
Subject: [lm-sensors] I2C 2.9.1 driver support for High Speed I2C (draft
Message-Id: <520AB2AD990DC04082102F77CA1726385B8994@dlee03.ent.ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greetings All,

In continuance of the discussion about HSI2C support
(http://archives.andrew.net.au/lm-sensors/msg31155.html ), I would like
to present for discussion a strategy to incorporate HSI2C support to the
current I2C driver (ver 2.9.1). 

 

Design considerations:

The I2C support in Linux is widespread with a large number of legacy
drivers already in existence. Introducing HS support has to fulfill the
following criteria:

1.       Support all existing driver sets (adaptor, algorithm and client
drivers) without any change to the existing code base.

2.       Support new HS I2C algorithm, adaptor and client drivers.

3.       Ability to support High speed and full speed I2C clients on the
same HSI2C bus (subject to hardware constraints).

4.       Performance loss should not be incurred due to this support.

5.       Should be simple enough to carry forward into various kernel
versions.

Multiple options are available for the extending I2C support to handle
HS mode. Among these are:

1.       Changing prototype of existing functions to notify about HS
capabilities.

2.       Auto detection of capability and configuring driver for
communication based on known capabilities.

3.       Using the flag field in pre-existing data structures by
introducing new definitions that are passed down.

Of these, options 1 and 2 were deemed in-appropriate due to
considerations mentioned previously. Option 3 is adopted as the viable
option and is described here.

This would allow legacy drivers to ignore the new functionality and yet
not restrict the functionality of HS capable drivers.

Choosing if HS mode is to be used for transfer or not:

Given a pre-amble overhead in case of HS transfers, it can be considered
if a HS operation is optimal for data transfers involving small number
of bytes. Here the choices are:

1.       Have the core driver to make a choice for HS transfer when
"i2c_master_send/recv" is used 

a)         Allow HS transfer if both client and adaptor are HS capable

b)         In addition to above, add a constraint that HS transfer to be
used if the number of bytes to be transferred is greater than a default
number of bytes. The default number of bytes can be one based on HS spec
overheads and software overheads

2.       Allow client to decide if the transfer should be HS or not by
setting proper flags while doing transfer using "i2c_transfer"

Option 1a along with 2 is being used for the current design as having
option 1b is to have additional overhead and making the i2c core driver
more draconian in terms of HS decision. The client drivers have now an
option of using either "i2c_master_send/recv" or using "i2c_transfer"
based on its own discretion. 

DMA transfer decision

At 3.4 Mbits/sec data transfer rate expected of HSI2C, implementing a
polling mode driver would defeat the purpose by using CPU resources
beyond acceptable limits. The alternative would be to use DMA to do the
data transfer. This results in the following options:

1.       DMA logic is implemented in the core driver itself.

2.       DMA logic is implemented in the master_xfer function
implementation of the algorithm driver.

To implement option 1 would force all HS adapters to use the same
transfer logic and not optimize based on system requirement. Example of
this scenario would be the usage of DMA chaining logic on one platform
while not using DMA chaining logic on another platform. It would also
make optimized logic for custom platforms difficult to achieve. However,
the advantage of this approach is to have a centralized logic which is
proven on multiple platforms readily available for the next platform.

Option 2 would have the advantage of having customizable DMA logic on
every platform. This would allow for a specific platform to optimize
it's logic as per the constraints inherent for the platform.
Disadvantage of this approach could be DMA transfer logic which may be
replicated against different platforms.

Option 2 is adopted here, as it is possible to abstract various adaptor
drivers if the DMA transfer logic is recurring at the same time allowing
maximum flexibility for adaptor drivers to optimize their DMA
implementations.

 

Design:

 

The hardware perspective: 

The HS implementation has two points of changes which differentiate
themselves from normal I2C transfer - one during the initialization and
the other during the data transfer phase (a different register access
needs to be done for HS transfer to take place).

 

The software perspective:

From the study of the relevant documentation and code, it is obvious
that there are two main transfer paths that are of interest to us:

1.       client drivers -> core driver -> adaptor driver

2.       user space application -> dev-intereface -> core driver ->
adaptor driver

 

1) Client driver to adaptor driver communication:

During initialization of the adaptor driver, it is capable of detecting
if it is HS capable or not and can do required hardware settings without
any modifications to existing I2C infrastructure. 

However, for the clients to communicate with the adaptor driver, it
could either use the "i2c_master_send/recv" or use the "i2c_transfer"
function. Both these calls percolate into a call of "master_xfer" to the
adaptor/algorithm driver. The i2c_msg parameter that this call receives
contains the information to be transferred over the I2C bus. 

 

If the i2c_msg->flags contain I2C_M_HS flag, the adaptor driver
initiates a HS transfer. All other parameters remain the same.

 

Now, the "i2c_master_send/recv" request contains the data to be
transmitted along with the client to which this is to be sent to. This
information is converted to the i2c_msg form by the core driver. Core
driver needs to make a decision here if the transfer needs to be in HS
mode or not. To do this, the simplest algorithm is to allow HS transfer
if both client and adaptor are HS capable.

"i2c_client->flags" contain I2C_M_HS flag to say that it is HS capable

"i2c_adapter-> flags" contain I2C_FUNC_HIGH_SPEED to say that it is HS
Capable. The same information is provided when the
"i2c_algorithm->functionality" is called

If both these conditions are met, the i2c_msg created and passed to the
adaptor driver would be of HS mode.

 

If a HS client driver is not interested in HS mode of transfer/ if it
would like to send a custom message, it can use the i2c_transfer
function with the required i2c_msg to do the transfer.

 

2) User space to adaptor driver communication:

Dev-interface:

The ioctls to the dev-interface driver provide the required
initialization for further data transfers to take place. Transfer take
place using either the "i2c_master_send/recv" or the "i2c_transfer"
functions as per requirement.

Only requirement for HS at this stage is to provide an extra ioctl that
will allow us to set the HS mode for transfers:

I2C_HIGH_SPEED may be used as the ioctl to do the same. This operation
is like the TEN bit addressing mode ioctl and will toggle the I2C_M_HS
flag of the client driver.

 

Proc-interface: (Disclaimer: This is purely optional :-) ) we may at our
discretion provide capability string too along with the name of the
adaptor, to state the capabilities of the adaptor. This is not in place
currently, and may not be a welcome addition to many who like simple and
concise information from proc. 

 

Synopsis of changes for HSI2C support:

The following new flags are to be added:

I2c_msg->flags contain I2C_M_HS

i2c_client->flags contain I2C_M_HS 

i2c_adapter-> flags contain I2C_FUNC_HIGH_SPEED  

i2c_algorithm->functionality  returns I2C_FUNC_HIGH_SPEED

dev-interface -> ioctl contain I2C_HIGH_SPEED

 

Caveats:

Implications to SMBus/slave mode is not taken into consideration and is
purely targeted at the HSI2C as in the
http://www.semiconductors.philips.com/acrobat/literature/9398/39340011.p
df specification.

 

Regards,

Nishanth Menon
