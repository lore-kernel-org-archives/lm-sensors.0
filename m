From: timm@fnal.gov (Steven Timm)
Date: Wed, 04 Jan 2006 15:03:03 +0000
Subject: [lm-sensors] Tips for Red Hat Enterprise Linux 4 Update 2?
Message-Id: <Pine.LNX.4.62.0601040857210.21136@snowball.fnal.gov>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Can anyone give a few pointers on what the status of the
drivers are in Red Hat Enterprise Linux 4 Update 2?
This distro advertises a kernel of 2.6.9-22.0.1
and the lm_sensors userspace rpm that ships with it
claims to be lm_sensors 2.8.7.

Does anyone know if Red Hat has in fact patched their
kernel with newer i2c/lm_sensors stuff  and kept the version
numbers the same, as they often do?  If not, is there
any other recourse to get the latest drivers?  i.e. is there
a good set of patches somewhere on the web site to patch and
recompile i2c/lm_sensors 2.9.2 (latest version) into the
heavily patched 2.6.9 series of kernels that redhat puts out?

The tests I have done on older hardware thus far indicate
that the lm_sensors that ships with the redhat kernel supports
most of the older stuff, but there are some newer boards with
w83792d chips where I definitely need the new w83792d driver,
and that is certainly not in the stock redhat packag.

Steve Timm

-- 
------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm at fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team

