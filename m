From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sat, 02 Oct 2010 12:03:58 +0000
Subject: Re: [lm-sensors] Sysfs attribute to specify device range
Message-Id: <4CA71FAE.9060900@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CA71DF0.5000309@cam.ac.uk>
In-Reply-To: <4CA71DF0.5000309@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 10/02/10 12:56, Jonathan Cameron wrote:
> Hi All,
> 
> This question is actually motivated by a light sensor driver
> proposed for IIO, but given we don't have an answer in our
> current abi and the problem seems a common one I thought
> I would ask you guys.  Firstly I'm not sure if you already
> have an interface for this!
> 
> We have a multi range sensor, to simplify the discussion, let us
> call it an adc.  So it's range can be configured to say 0-1V, 0-2V, 0-4V.
> We would like to be able to control this via a sysfs attribute and
> have been trying to work out what to call it.
> 
> in1_max is out because I believe that is used for alarms (whilst we have
> different, more general, naming for those, we don't want to muddy the
> waters by reusing the name).
> 
> in1_range is a bit non specific as it isn't clear how to specify future
> devices that support say 1-2V range.  We could allow a pair of values
> to specify the range (fine as single conceptual entity).  If only one
> is present then assume the minimum is 0? 
> 
> Pointers to drivers which are already handling this case, bits of the
> hwmon abi that I missed or suggestions all welcome.
> 
Actually from our point of view it occurs to me that we can just treat this
case as an on chip calibration scale factor so we do have an interface for
this in IIO _calibscale. I was clearly half asleep this morning.  Still,
I would be interested to here if there is an equivalent in hwmon. Sorry for
the noise.

Jonathan


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
