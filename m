From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: lm_sensors support for  H8S/2148  chip by hitachi
Message-Id: <3E6A7C94.2050407@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <62A6A06E481DD6119E350008C7A47F9D039F5592@ffz00zm1.ffz00e.mail.dresdner.net>
In-Reply-To: <62A6A06E481DD6119E350008C7A47F9D039F5592@ffz00zm1.ffz00e.mail.dresdner.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

from the information at the link below it appears that this is a general-purpose
controller (perhaps similar to the Dallas 82CH10 that we don't support).
As the interface to the controller will depend on the software running in the
controller there is no way to write a driver without detailed info
on the SW interface. Therefore it's quite unlikely we will ever
have a driver for it. You may be able to get some sensor info
via ACPI or IPMI for these servers instead. Good luck.

Schott, Darcy wrote:
> Hi,
> 
> I am currently involved in setting up a bundle of IBM x335 servers 
> with RedHat 8. 
> 
> Since lm_sensors ships with RedHat 8 it would be nice to use this 
> package to monitor the servers.
> 
> I found no reference to the intalled Hitachi H8S/2148 sensor chip on 
> the lm_sensors website. 
> The website regarding this chip can be found here:
> http://www.hitachi-eu.com/hel/ecg/products/micro/8_16bit/h8s/2148/h8s_2148_e
> .html
> 
> Is there a possibility to configure lm_sensors to read from this chip
> or is it unsupported? 
> 
> If it is not supported, are there plans to include support for this 
> chip in a future release?
> 
> Thanks for your help and your outstanding work on lm_sensors.
> 
> Cheers,
> 
> Darcy
> 
> 
> Darcy Roger Schott 
> Dresdner Bank AG 
> Group Risk Control - Risk Methodology Trading - Risk Engineering 
> Juergen Ponto Platz 1 / 8.OG
> 60301 Frankfurt / Main 
> Germany
> phone: 	+49 (0)69 263 16871
> facsimile: 	+49 (0)69 263 59850
> 
> "Any sufficiently advanced technology is indistinguishable from magic."
> 
