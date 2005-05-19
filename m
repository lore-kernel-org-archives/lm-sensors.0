From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: sensors error
Message-Id: <20020809092113.F32640@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I think we just receintly got some info on that chip.  If there is 
anything written yet (it may be too soon), it would be in CVS.


Phil

On Fri, Aug 09, 2002 at 07:55:57AM -0700, Bryan Dang wrote:
> Phil,
> 
> The Intel Westvile server uses the ADM1026 chips. Sensors-detect probed
> ADM1021. I did not find the ADM1026 drivers from about 16 sensors drivers
> that lm_sensors generated. Do you know if there is a driver for this ADM1026
> chip?
> 
> Bryan
> 
> 
> -----Original Message-----
> From: phil@netroedge.com [mailto:phil@netroedge.com]
> Sent: Thursday, August 08, 2002 4:44 PM
> To: Bryan Dang
> Subject: Re: sensors error
> 
> 
> 
> Sorry, I can't say w/o knowing any related details about your
> hardware, install setup, versions, etc.  Try reading the 
> documentation, FAQ's, information on our site (like the support 
> tickets), etc.
> 
> 
> Phil
> 
> On Thu, Aug 08, 2002 at 04:16:53PM -0700, Bryan Dang wrote:
> > Thanks Phil. 'make install" didn't work right for me. The
> /etc/sensors.conf
> > wasn't generated. But I copied lm_sensors/prog/etc/sensors.conf.eg over
> and
> > it worked now. Although it only showed the Board and CPU temperature. Is
> > that it? The sensors-detect probed the ADM1021 chip on my board.
> > 
> > -----Original Message-----
> > From: phil@netroedge.com [mailto:phil@netroedge.com]
> > Sent: Thursday, August 08, 2002 3:49 PM
> > To: Bryan Dang
> > Subject: Re: sensors error
> > 
> > 
> > 
> > Probably /etc/sensors.conf?  Doing a 'make install' should put it 
> > there, but you might be using the package w/o doing an install?
> > 
> > 
> > Phil
> > 
> > On Thu, Aug 08, 2002 at 03:47:32PM -0700, Bryan Dang wrote:
> > > Phil,
> > > 
> > > I ran into this error when running "sensors:
> > > 
> > > Could not locate or open config file!
> > > 
> > > What config file and where is it supposed to be located?
> > > 
> > > Thanks
> > > 
> > > Bryan Dang
> > > Firmware Engineer
> > > Quantum Corporation
> > > Storage Solutions Group
> > > P.O. Box 57100, Irvine, CA 92619-7100
> > > 
> > > Tel:	(949) 856-7807
> > > Fax:	(949) 856-7799
> > > bryan.dang@quantum.com
> > > www.quantum.com
> > > 
> > 
> > -- 
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> 
> -- 
> Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
>    phil@netroedge.com -- http://www.netroedge.com/~phil
>  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
