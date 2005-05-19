From: Axel.Thimm@physik.fu-berlin.de (Axel Thimm)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Success & packaging questions (was: i2c & lm_sensors for RH)
Message-Id: <20030807160511.GA27558@puariko.nirvana>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

kernel & userland tools work very well! Thanks for all the advice so
far.

I am now resolving some last packaging questions:
o libsensors.so.1 compatibility:
  Some packages are dynamically linked to pre-2.8.0 lm_sensors. I
  would now package that into a lm_sensors270-2.7.0 compatibility
  package (RH naming convention for compat. versions). Will the tools
  interface over libsensors.so.1 function properly, or at all?

o [lm_sensors-]sensord
  A year ago I started packaging sensord with an lm_sensors prefix. I
  am now considering dropping the prefix to simplify the name (with
  the resp. steps involved in packaging resolution). Is that a bad
  idea?

On Sat, Aug 02, 2003 at 07:20:08PM +0200, Axel Thimm wrote:
> Is anyone working on this? If not, I'd be interested (I have been
> maintaining rpms for kernel and userland parts for i2c/lm_sensors
> 2.7.0 at atrpms).
> 
> I am already trying to patch the i2c core and surrounding patches into
> the latest RH errata kernel (based on 2.4.21-pre3). I might have a
> question or two, and could use testers, since I am doing it upon
> request, and the machines I currently have available aren't that
> sensor friendly (one is a Thinkpad ...).



-- 
Axel.Thimm@physik.fu-berlin.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030807/66a2ca92/attachment.bin
