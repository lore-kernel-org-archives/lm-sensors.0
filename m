From: andre.fisser@imtech.nl (Andre Fisser)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: I2C block read fixed size to 32
Message-Id: <F815C23DC37A74429D347AAE3FAC186009F6BF@mpc034.mountside.nl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

are there plans to remove the fixed size of i2c block reads? I use the I2C
driver to communicate through the printer port with a kind of Philips dongle
to a custom microprocessor circuit. The fixed block size is wasting
bus-bandwidth which is a problem for me.
I'm planning to remove this limitation myself if there's nobody already
working on it. Maybe you guys have some advice for me how it can be best
done?

Best regards,
Andre


Andr? Fisser

Imtech ICT Technical Systems
Flight Forum 800,
5657 DV  Eindhoven

Telephone +31 (0)40 8484444 
Fax       +31 (0)40 8484440 
Email     Andre.Fisser@Imtech.nl  
www       www.imtech.nl 

Imtech ICT is een full service ICT-dienstverlener die op een no-nonsense
manier bijdraagt aan het succes van haar klanten. Imtech ICT biedt
hoogwaardige dienstverlening op het gebied van projectmanagement, advies,
technische automatisering, informatisering en communicatietechnologie, en is
onderdeel van het beursgenoteerde Imtech.

