From: siegs@hotmail.com (John Siegler)
Date: Thu, 19 May 2005 06:25:50 +0000
Subject: Raw sensor readings
Message-Id: <BAY101-F359CFE2F24A8AFB4A4547A4330@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY101-F36EBF0A9799BF1039FC5FEA43E0@phx.gbl>
In-Reply-To: <BAY101-F36EBF0A9799BF1039FC5FEA43E0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks Mark and Philip. I really appreciate your quick responses.

Instead of trying to code everything myself using lm_sensors (which I was 
informed wasn't possible, thank you), I decided to use FreeBSD and the code 
from the previous semester's project. Now I can simply call a method brand() 
and retrieve a supposedly random number based on the sensors. My job for 
this semester is to test it for randomness and perhaps make a webpage for 
it. Chi-squared analysis yields that 5/10 groups of readings are random. Not 
bad for a start.

lm_sensors is quite extensive and easy to use, kudos to that.

Thanks again,
John


&gt;From: Philip Pokorny &lt;ppokorny@penguincomputing.com&gt;
&gt;To: John Siegler &lt;siegs@hotmail.com&gt;
&gt;CC: lm78@Stimpy.netroedge.com
&gt;Subject: Re: Raw sensor readings
&gt;Date: Sat, 09 Apr 2005 22:22:24 -0700
&gt;
&gt;In addition to what Mark said...
&gt;
&gt;Several of the sensors include extensive low pass filtering and
&gt;averaging specifically to eliminate jitter in the low order bits and
&gt;provide a consistent reading.
&gt;
&gt;Some chips can have this filtering disabled, but that runs counter
&gt;to the original purpose and intent of lm_sensors...
&gt;
&gt;:v)
&gt;
&gt;John Siegler wrote:
&gt;
&gt;&gt;Hello,
&gt;&gt;
&gt;&gt;I apologize if this is the wrong place to ask, but I am simply
&gt;&gt;wondering what is the best way to obtain the raw readings (low
&gt;&gt;order bits) from the sensors, in order to calculate randomness. I
&gt;&gt;read in the values from the /proc/sys/dev/sensors files (using 2.4
&gt;&gt;kernel), but the values did not seem to contain the low order bits
&gt;&gt;since the fan speed and cpu temp did not change much. Is there an
&gt;&gt;easy way to access this data using libsensors, or will that give me
&gt;&gt;the same not-very-random data? Or is there a driver available?
&gt;&gt;
&gt;&gt;Thank you for your time,
&gt;&gt;John
&gt;&gt;
&gt;&gt;
&gt;
&gt;
&gt;

