From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: Acquiring an i2c adapter.
Message-Id: <4038254E.3020206@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4037FB21.20701@linuxmail.org>
In-Reply-To: <4037FB21.20701@linuxmail.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry I didn't answer your first query.

We've been wondering over here at sensors what the point was of unique IDs.
nobody seemed to use them.

Your application is an obvious example of their purpose.
On the Voodoo, the DDC bus should have a separate ID from the I2C bus.
Then you could distinguish them without a strcmp.

Perhaps we should add IDs to 2.6?

As for the dummy driver, it sounds strange at first but is probably
the best way to do it.


Perry Gilfillan wrote:
> Hello,
> 
> I've resolved my trouble with the aparently deprecated function 
> i2c_get_client.  One response I had indicated it was no longer used 
> because of locking issues.
> 
> The method I'm using is to attach a dummy driver to the adapter I'm
> interested in, the i2c-voodoo3 module, then use a derivative of the
> i2c_clients_command function.
> 
> At present in the 2.4 kernel, my i2c_driver->attach_adapter function has
> to do a string cmp on the adapter name to get the right adapter.  The
> i2c-voodoo3 module provides an i2c and a ddc bus, and there is no other
> way to distinguish them.
> 
> This can all be found in the voodoo-i2c.c file at the v3tv site below. 
> This file still has optional support for the v3tv-i2c_adapter, with the 
>  INCLUDE_I2C define.
> 
> I'm confused by the i2c_get_adapter function.  The prototype has an
> argument called 'id' yet the function examines the 'nr' member of the
> i2c_adapter struct.
> 
> I was going to use i2c_get_adapter, but would be better served if 
> adapters could be identified by the 'class' field, which would be 
> I2C_ADAP_CLASS_TV_ANALOG for the v3tv, bttv and family.
> 
> What is the actual intent of the i2c_get_adapter function?
> 
> Thanks,
> 
> Perry
> -----
> V3TV: http://gilfillan.org:8000/v3tv/
> VPX3224: http://gilfillan.org:8000/vpx3224/
> 
> 
> 

