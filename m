From: andre.fisser@imtech.nl (Andre Fisser)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: I2C block read fixed size to 32
Message-Id: <F815C23DC37A74429D347AAE3FAC186009F6C1@mpc034.mountside.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <F815C23DC37A74429D347AAE3FAC186009F6BF@mpc034.mountside.nl>
In-Reply-To: <F815C23DC37A74429D347AAE3FAC186009F6BF@mpc034.mountside.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Mark Studebaker wrote:
> 
> good question.
> 
> you want to make the size bigger or smaller?

I need it to be smaller, but a maximum size of 32 is o.k. for me.

> I'll assume you are using a bit-banging (i2c-algo-bit) adatper here...

Yes.
 
> It's true, if you use the call
> i2c_smbus_read_i2c_block_data(), 
> the size is fixed at 32. This is enforced in these functions 
> and in i2c_smbus_xfer_emulated().
> 
> You can avoid this limitation by making a direct call to 
> i2c_transfer(), you should be able to find some drivers in 
> the kernel that use i2c_transfer() 
> as an example.

I think that is too low level, I need to call that function from user-space;
I don't want to make a special driver-module for my device.
 
> If you have a proposal on a clean way to set the size on calls to
> i2c_smbus_read_i2c_block_data()
> we'll be happy to discuss it with you.

I have a solution that works for me. 
The changes I made are quite small. I changed the
i2c_smbus_read_i2c_block_data function and added a length parameter. I think
this is the right thing to do because only the I2C master knows how many
byte to transfer. Then I pass the length in the i2c_smbus_data union in
block[0] down to all driver sub-functions, as it is done in the _write_
functions. This allows me to adjust the block-size between 1..32, that's
good enough for me. 
Of course this is a change in the API and will probably break some existing
clients. I don't have any, so no problem for me ;-) I don't know if this is
acceptable for a future version of the i2c driver. And there is still a max.
size of 32 bytes for the transfer, but changing that would require to
allocate the buffer dynamically. I think that's not worth the effort
required.

Groetjes,
Andre
 
> Andre Fisser wrote:
> > Hi,
> > 
> > are there plans to remove the fixed size of i2c block 
> reads? I use the 
> > I2C driver to communicate through the printer port with a kind of 
> > Philips dongle to a custom microprocessor circuit. The fixed block 
> > size is wasting bus-bandwidth which is a problem for me. 
> I'm planning 
> > to remove this limitation myself if there's nobody already 
> working on 
> > it. Maybe you guys have some advice for me how it can be best done?
> > 
> > Best regards,
> > Andre
> > 
> > 
> > Andr? Fisser
> > 
> > Imtech ICT Technical Systems
> > Flight Forum 800,
> > 5657 DV  Eindhoven
> > 
> > Telephone +31 (0)40 8484444 
> > Fax       +31 (0)40 8484440 
> > Email     Andre.Fisser@Imtech.nl  
> > www       www.imtech.nl 
> > 
> > Imtech ICT is een full service ICT-dienstverlener die op een 
> > no-nonsense manier bijdraagt aan het succes van haar 
> klanten. Imtech 
> > ICT biedt hoogwaardige dienstverlening op het gebied van 
> > projectmanagement, advies, technische automatisering, 
> informatisering 
> > en communicatietechnologie, en is onderdeel van het beursgenoteerde 
> > Imtech.
> > 
> > 
> > 
> 
