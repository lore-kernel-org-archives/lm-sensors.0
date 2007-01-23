From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 23 Jan 2007 08:13:08 +0000
Subject: [lm-sensors] question about vt1211
Message-Id: <20070123091308.0df80ec8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0701190725j2620de3dvd521e23c690e72e@mail.gmail.com>
In-Reply-To: <191fb4ca0701190725j2620de3dvd521e23c690e72e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sasha,

On Mon, 22 Jan 2007 16:51:24 -0800 (PST), Sasha Raykhman wrote:
> I need some help in explaining how to install 2.10.2 package.  
> 
> The problem I have is that I am compiling kernel on my
> host computer for a different target board. Installation
> instructions and make file presented in the package will
> install necessary files on the host, but not in my source
> tree which I need to compile for the target .  Is there a
> way to solve the problem?

Try setting the DESTDIR variable to your staged installation root.
Either edit the Makefile to set it, or pass it on the command line:
# make DESTDIR=/tmp/fakeroot user_install
Then you can copy the files from /tmp/fakeroot to your target host.

-- 
Jean Delvare

