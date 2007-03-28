From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 28 Mar 2007 11:20:33 +0000
Subject: Re: [lm-sensors] Motherboard-specific configurations (sensors4mobo)
Message-Id: <460A4F81.5080401@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <46084A44.4070101@eberian.com>
In-Reply-To: <46084A44.4070101@eberian.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Ivo Manca wrote:
> Hey Ed,
> 
>> I looked at sqlite when developing sensors4mobo but many ISPs do not 
>> include it and I did not want to add any dependencies that would limit 
>> usage or make installation harder.
> 

<lots of explanation by Ivo about sqlite plans snipped>

Actually I have been thinking about using the annotating of sensors.conf file 
myself in the past, but I thought sqlite would be easier to use, esp. on the 
web-side. Since with sensors4mobo we kinda get the web-side for free, and I 
also _really_ like the idea of the database being a dir of textfiles with one 
file per motherboard allowing for easy tinkering / experimenting by end users, 
I think it might be a good idea to go with the dir with one textfile per mobo.

But less discuss this further tomorrow at our (face to face) meeting. Jean, any 
thoughts / preferences on this?

Regards,

Hans


p.s.

Ed, I'm really glad you've stepped forward with this, it could really be a 
great help!


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
