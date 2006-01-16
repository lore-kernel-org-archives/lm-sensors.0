From: jim.cromie@gmail.com (Jim Cromie)
Date: Mon, 16 Jan 2006 01:18:16 +0000
Subject: [lm-sensors] Super-IO locking
Message-Id: <43CAF458.8080707@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Jean and friends,

SuperIO devices typically hide many functional units behind 2 io-bus 
addresses.
These various units/devices will obviously have separate drivers to 
control them,
leading to the potential that 2 drivers will clash over the 'port'.

As I see it, we need a place to put a lock for the sio port, ideally without
creating a dependency of one driver on another. That said, its seems a 
bit like
overkill to create a 3rd module which merely holds the lock that both 
drivers use,
and therefore depend upon.  IOW, this replaces one dependency for another.

OTOH, an sio-lock manager which provides a lock for any sio port user
(that uses the helper) could be justified.  There are a bunch of SuperIO
units in the hwmon/* world, so this seems like the right place to find
potential module clients.

Any comments ?


