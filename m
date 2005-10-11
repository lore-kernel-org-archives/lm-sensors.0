From: grant_lkml@dodo.com.au (Grant Coady)
Date: Tue, 11 Oct 2005 02:02:59 +0000
Subject: [lm-sensors] lm_sensors in an embedded environment
Message-Id: <720mk19sr9ktsvmc7en4qhi1v4h0bdk6ro@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6db3e120510101405xdbb6920wfdf863ba55896477@mail.gmail.com>
In-Reply-To: <6db3e120510101405xdbb6920wfdf863ba55896477@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 10 Oct 2005 15:05:17 -0600, Robert Teel <rob.teel@gmail.com> wrote:

>I am curious if anyone has tried to use the lm_sensor software in an embedded
>environment.  I would like to get uClinux up on an FPGA or small micro, and run
>lm_sensors on top of that to monitor other rack mount processor boards.
>

Just a small shell script monitoring sysfs values would do that, 
Temperature values are degrees Celsius x 1000 --> simple integer
compare.  No need for lm_sensors at all :o)

Grant.

