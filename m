From: dbailey@digium.com (Doug Bailey)
Date: Mon, 05 Feb 2007 19:50:37 +0000
Subject: [lm-sensors] ADT75 sensor
Message-Id: <15533071.11811170705037131.JavaMail.root@jupiler.digium.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am writing an interface for a Analog Devices ADT75 using a uClinux distribution for the blackfin processor.  I want to use the HWMON interface to do this.  

The distribution does not specifically have an ADT75 sensor but does have a LM75 sensor. Unfortunately, the addition of the one-shot register in the ADT75 causes the LM75_detect portion of the driver to fail.  In addition the temp precision is different on the ADT75 from the LM75.  .  
		
I don't see on your web site that anyone has already generated an ADT75 driver. Therefore I made the relatively simple modifications to make the LM75 into an ADT75.  In doing this I have run into a couple of issues: 
		
- My problems come in that I do not have an i2c ID for the driver (There is no I2C_DRIVERID_ADT75.)  Is there a way of getting one of these defined?
 
- I would like to access a couple of the ADT75 registers through sysfs that currently do not have defined interfaces. (Most notably the one shot register and the fault queue registers.)  Is there some guideline on how these should be defined?  
		
I can easily make these items but I would prefer to follow the guidelines used for the lm-sensors project.  Any suggestions? 

Thanks 
Doug Bailey

