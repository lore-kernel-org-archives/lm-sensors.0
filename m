From: "Tomas Larsson" <tomas@tlec.se>
Date: Sun, 08 Sep 2013 21:47:31 +0000
Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
Message-Id: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAODW98Kbgz1AvzLp3XDX+OcBAAAAAA==@tlec.se>
List-Id: <lm-sensors.vger.kernel.org>
References: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
In-Reply-To: <!&!AAAAAAAAAAAYAAAAAAAAAGE4UvMgtwJIpJJKF65P6VPCgAAAEAAAAEchc8MJx35LlZC8CEJITyEBAAAAAA==@tlec.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> -----Original Message-----
> From: Guenter Roeck [mailto:linux@roeck-us.net]
> Sent: Sunday, September 08, 2013 11:41 PM
> To: Tomas Larsson; LM Sensors
> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
> 
> On 09/08/2013 02:27 PM, Tomas Larsson wrote:
> >> -----Original Message-----
> >> From: Guenter Roeck [mailto:linux@roeck-us.net]
> >> Sent: Sunday, September 08, 2013 11:20 PM
> >> To: Tomas Larsson
> >> Cc: 'Jean Delvare'; lm-sensors@lm-sensors.org
> >> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
> >>
> >> On 09/08/2013 01:01 PM, Tomas Larsson wrote:
> >>>> -----Original Message-----
> >>>> From: Jean Delvare [mailto:khali@linux-fr.org]
> >>>> Sent: Sunday, September 08, 2013 9:10 PM
> >>>> To: Guenter Roeck
> >>>> Cc: Tomas Larsson; lm-sensors@lm-sensors.org
> >>>> Subject: Re: [lm-sensors] Whats wrong with LM-Sensors
> >>>>
> >>>> On Sun, 08 Sep 2013 11:58:39 -0700, Guenter Roeck wrote:
> >>>>> Different driver. Centos 6.4 uses the coretemp driver which gets
> >>>>> the temperature from the CPU directly. Unfortunately, Centos 6.4
> >>>>> is quite old when it comes to kernel version, and so is its
> >>>>> coretemp
> > driver.
> >>>>> The displayed temperatures in your version are all wrong; the
> >>>>> maximum
> >>>> temperature for Atom 330 is 125 degrees C, not 90 degrees C.
> >>>>> You'll have to add 35 degrees C to the displayed temperature.
> >>>>>
> >>>>> You could either update the coretemp driver to a later version to
> >>>>> fix this, or add the offset to /etc/sensors3.conf.
> >>>>>
> >>>>> Note that CPU temperatures are notoriously unreliable.
> >>>>
> >>>> "Inaccurate in the low temperature range" is a better way to
> >>>> describe the situation IMHO. The coretemp values are reliably
> >>>> telling the user when the temperature gets too close to the high
limit.
> >>>>
> >>>> --
> >>>> Jean Delvare
> >>>
> >>> Well, I'm aware of that, what I want to know is when the fan fails,
> >>> these 40mm fans are not that reliable, unfortunately.
> >>
> >> Not sure if you can use the cpu temperature to predict if the fans
> >> are
> > working
> >> or not. The CPU can get pretty hot under load, even with the fans
working.
> >>
> >> Your initial e-mail showed the fan speeds as 0. Are they broken or
> >> turned
> > off
> >> or not connected to the fan speed sensors ?
> >>
> >> Guenter
> >
> > Haven't got a clue why it says that they are 0, they definitely work
> > now (changed the fans today), They are 3-pins and connected to the
> > correct header.
> >
> 
> Do you get a non-zero speed reported after replacing the fans ? If the
> reported speed is still 0, I am not sure I understand what is going on.
> 
> Guenter

Yes.
Haven't checked what BIOS reports though, if it reports any fan-speeds.

Tomas Larsson.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
