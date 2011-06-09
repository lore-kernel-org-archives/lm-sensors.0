From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 09 Jun 2011 07:11:28 +0000
Subject: Re: [lm-sensors] Master Configuration File Location
Message-Id: <20110609091128.638fc696@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <COL119-W612399EB5F87CF7E73BF57BA650@phx.gbl>
In-Reply-To: <COL119-W612399EB5F87CF7E73BF57BA650@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Derek,

On Wed, 8 Jun 2011 17:24:19 -0700, derek bonuccelli wrote:
> I apologize if this is the wrong place to ask this but I am at my wits end. What I am looking to do is copy the config file to identical motherboards on remote machines that have not run sensors-detect. From an already installed/configured computer I attempted to find a file, if deleted, makes it return back to "not configured. run sensors-detect" state, so that I can copy the file over to another computer and be good to go. I have been unsuccessful at finding such a file, and removing lm_sensors does not clear the config.
> Deleting the following files does not stop 'sensors' from outputting sensor data.
> /etc/init.d/lm_sensors/etc/sysconfig/lm_sensors (also tried deleting MODULE_ line to no avail)/etc/sensors.conf
> If anyone can point me in the right direction I would be forever grateful. Thank you in advance. 		 	   		  

The decision to run sensors-detect at boot is not a standard behavior,
it is something added by your distribution. So, how to stop it is a
question for the maintainer of the lm-sensors package in your
distribution.

Searching for string "sensors-detect" in /etc/init.d/* might reveal
something.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
