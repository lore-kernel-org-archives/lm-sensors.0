From: Matt Roberds <mattroberds@cox.net>
Date: Wed, 22 Apr 2009 04:04:06 +0000
Subject: Re: [lm-sensors] lm_sensors support for Dell PowerEdge R200 and Nat
Message-Id: <Pine.LNX.4.64.0904212251490.10779@birdbird.example.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <49EE1186.7060100@Winfirst.Com>
In-Reply-To: <49EE1186.7060100@Winfirst.Com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 21 Apr 2009, Mark E. Hansen wrote:
> I've install lm_sensors 2.10 (from an RPM: lm_sensors-2.10.7-4.el5)
> and run sensors-detect.

Old version is old.  :)  You might at least grab the latest and greatest
sensors-detect at
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt
and see what it says.  sensors-detect is independent of the rest of the
sensors package; you can run it even if you don't have lm_sensors
installed.  (You do need Perl, but if an old version of sensors-detect
works, you already have that.)

http://www.lm-sensors.org/ticket/2182 has a little more information on
this particular chip; apparently there is more than one chip that gets
detected as this one.  That page mentions a recent (Feb 2009) change to
sensors-detect to better figure out which chip you actually have.

If you go into the BIOS setup, are sensor values (voltages, fan speeds)
displayed in there?  If there is an "enable sensors" setting, make sure
it is turned on.

Matt Roberds


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
