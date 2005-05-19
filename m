From: phil@edgedesign.us (Philip Edelbrock)
Date: Thu, 19 May 2005 06:25:30 +0000
Subject: Bugzilla setup for Lm_sensors
Message-Id: <41E718CA.3070305@edgedesign.us>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Please see below for our conversation on Bugzilla topics.  Comments wanted!


Phil

Axel Thimm wrote:
> On Mon, Jan 10, 2005 at 03:08:41PM -0800, Philip Edelbrock wrote:
> 
>>
>>Axel Thimm wrote:
>>
>>
>>>>I'm thinking 'i2c' and 'lm_sensors' for the products. And then breaking 
>>>>out each driver (chip and bus) for the components, each app in 'prog' 
>>>>(e.g. 'i2c-detect','sensors-detect',etc.) and adding either a catchall 
>>>>for the rest of the code or breaking them out further (e.g. 'dev', 
>>>>'proc', 'core', etc.).
>>>>
>>>>What do you think?
>>>
>>>
>>>That sounds sane. The most invariant decision is the products
>>>part. components can be easily added or removed or left unspecified.
>>>
>>>I wished there were a hierachical structure in components, so that one
>>>could use
>>>
>>>|-->chips
>>>|  |-->...
>>>|  |-->...
>>>|-->busses
>>>
>>>but there isn't, it has to be kept flat (or we embed the hierachy in
>>>the components like "chips:lm93").
>>>
>>
>>Yeah.  The nice thing with the project is that all bus drivers start 
>>with 'i2c-', so by the names alone we can tell if it is a chip or bus 
>>driver.  But will that be abvious enough for everyone else? (Especially 
>>users submitting bugs?)  But, it would look add to see all bus drivers 
>>labelled the same "busses:i2c-..."
> 
> 
> I agree, it should be kept as simple as possible, and there aren't
> miriads of components (Red Hat for instance has > 1000 for each rpm
> package).
> 
> So how about simply using
> 
> adm1021 adm1024 adm1025 adm1026 adm1031 adm9240 asb100 bmcsensors
> bt869 ddcmon dmi_scan ds1307 ds1621 eeprom fscher fscpos fscscy
> gl518sm gl520sm i2c-adap-ibm_ocp i2c-algo-8xx i2c-algo-bit
> i2c-algo-biths i2c-algo-ibm_ocp i2c-algo-pcf i2c-ali1535 i2c-ali15x3
> i2c-amd756 i2c-amd756-s4882 i2c-amd8111 i2c-core i2c-dev i2c-elektor
> i2c-elv i2c-frodo i2c-hydra i2c-i801 i2c-i810 i2c-iop3xx i2c-ipmb
> i2c-ipmi i2c-isa i2c-keywest i2c-nforce2 i2c-pcf-epp i2c-philips-par
> i2c-piix4 i2c-pport i2c-proc i2c-rpx i2c-savage4 i2c-sis5595
> i2c-sis630 i2c-sis645 i2c-tsunami i2c-velleman i2c-via i2c-viapro
> i2c-virtual i2c-voodoo3 icspll it87 lm63 lm75 lm78 lm80 lm83 lm85 lm87
> lm90 lm92 lm93 ltc1710 matorb max1619 max6650 maxilife mtp008 pc87360
> pca9540 pca954x pcf8574 pcf8591 saa1064 sis5595 smartbatt smbus-arp
> smsc47m1 thmc50 via686a vt1211 vt8231 w83627hf w83781d w83l785ts
> xeontemp
> 
> for the kernel components?
> 
> The main purpose of components is for developers to be auto-assigned
> them and to be able to sort easier through the bugs.
