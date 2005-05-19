From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:42 +0000
Subject: Linux 2.6.3, lm_sensors 2.8.5
Message-Id: <40358B8A.6070706@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218232559.2621d402.khali@linux-fr.org>
In-Reply-To: <20040218232559.2621d402.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I don't think we should do a sensors release just because of w83l785ts.

We also shouldn't be forcing people to upgrade i2c releases.
The last couple of new sensors drivers have not had #ifndef I2C_DRIVERID_xxx
in the new drivers, which forces people to upgrade i2c for very little reason.
IMO we should always #ifndef the driverids in new drivers.

Jean Delvare wrote:
> Hi all,
> 
> Linux 2.6.3 is out. We want to release lm_sensors 2.8.5, don't we?
> 
> I know this is only two weeks since the last release, but I am not
> responsible for the very short cycle of Linux 2.6.3. And it happens that
> the w83l785ts driver in Linux 2.6.3 isn't compatible with libsensors
> from lm_sensors 2.8.4. There may be other compatibility issues, but this
> is the main one I can think of.
> 
> So, according to Greg's theory, we should release a new version of
> lm_sensors, numbered 2.8.5. OTOH, we probably don't want to release i2c
> 2.8.5 with an empty change list.
> 
> I propose to set the deadline to Friday, February 20th, 2004.
> 
