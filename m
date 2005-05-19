From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:01 +0000
Subject: temperatures
Message-Id: <Pine.LNX.4.58.0406171527420.6087@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <opr9pzmdztlsrnb1@localhost>
In-Reply-To: <opr9pzmdztlsrnb1@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



On Thu, 17 Jun 2004, William wrote:

> Hello Rudolf;
> There is no /etc/modules in my OS.
> I'm wondering if it should be pasted into the specified folder as
> something other than a text file. I don't yet know how to do this.
> William

Hello,


Step 1:
Do you know the module names?

If not, just after sensors-detect exits there is written what modules
should be inserted for your system. You need to edit /etc/rc.d/rc.modules
Its a text file, writable by root.

lines are like

#this is comment
modprobe some_module_name

You will just add for EXAMPLE

modprobe i2c-isa
modprobe ....

Step 2: How to edit this file.

Simplest way is to check if you have some textmode editor, like
vi, vim or joe.

become root with this command:
su
(type your root password)
cd /etc/rc.d/
joe rc.modules

Now use cursor keys, backspace to delete just like any other editor.

modprobe yourmodule1
modprobe yourmodule2

When done editing, press and hold ctrl key and press k x
your file is saved.

If you use vi or vim, type
vi rc.modules

press i key

use cursor lines to go to the end of file add

modprobe yourmodule1
modprobe yourmodule2

press esc
press :
press w
press q
press enter

To abort editing simply close terminal window.

I hope this helps for now.

Regards

Rudolf
