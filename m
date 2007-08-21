From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Aug 2007 14:50:44 +0000
Subject: Re: [lm-sensors] Submitting motherboard-specific support? (w/
Message-Id: <20070821165044.0fc540d0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46C997B4.50509@dolbeau.org>
In-Reply-To: <46C997B4.50509@dolbeau.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 21 Aug 2007 14:53:31 +0200, Hans de Goede wrote:
> Axel Thimm wrote:
> > Hans, maybe your PHP friend expert (is that Romain copied in the Cc?)
> > would be interested in this general purpose registration module
> > stealing some methods from mailman?
> (...)
> Let me check if I understand you correctly, you want to have a registration 
> module, for users to register themselves as trac user, which has some spam bot 
> prevention methods, like sending a confirmation mail and maybe also such a 
> picture with bad readable text? (which has a name I know, but not right now :)
> 
> But wouldn't it be better to write such a thing in python and submit it for 
> upstream trac inclusion? Has anyone already searched the web to see if such a 
> thing exists?

I was about to suggest the very same. Trac really lacks this feature
and it would benefit to all communities using it if written in python
and integrated cleanly. I can't believe that we are the only community
being hurt by the spam in trac.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
