From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: I2C block read fixed size to 32
Message-Id: <40CF853B.1050208@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <F815C23DC37A74429D347AAE3FAC186009F6BF@mpc034.mountside.nl>
In-Reply-To: <F815C23DC37A74429D347AAE3FAC186009F6BF@mpc034.mountside.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

good question.

you want to make the size bigger or smaller?
I'll assume you are using a bit-banging (i2c-algo-bit) adatper here...

It's true, if you use the call
i2c_smbus_read_i2c_block_data(), 
the size is fixed at 32. This is enforced in these functions
and in i2c_smbus_xfer_emulated().

You can avoid this limitation by making a direct call to i2c_transfer(),
you should be able to find some drivers in the kernel that use i2c_transfer() 
as an example.

If you have a proposal on a clean way to set the size on calls to
i2c_smbus_read_i2c_block_data()
we'll be happy to discuss it with you.

mds



Andre Fisser wrote:
> Hi,
> 
> are there plans to remove the fixed size of i2c block reads? I use the I2C
> driver to communicate through the printer port with a kind of Philips dongle
> to a custom microprocessor circuit. The fixed block size is wasting
> bus-bandwidth which is a problem for me.
> I'm planning to remove this limitation myself if there's nobody already
> working on it. Maybe you guys have some advice for me how it can be best
> done?
> 
> Best regards,
> Andre
> 
> 
> Andr? Fisser
> 
> Imtech ICT Technical Systems
> Flight Forum 800,
> 5657 DV  Eindhoven
> 
> Telephone +31 (0)40 8484444 
> Fax       +31 (0)40 8484440 
> Email     Andre.Fisser@Imtech.nl  
> www       www.imtech.nl 
> 
> Imtech ICT is een full service ICT-dienstverlener die op een no-nonsense
> manier bijdraagt aan het succes van haar klanten. Imtech ICT biedt
> hoogwaardige dienstverlening op het gebied van projectmanagement, advies,
> technische automatisering, informatisering en communicatietechnologie, en is
> onderdeel van het beursgenoteerde Imtech.
> 
> 
> 
