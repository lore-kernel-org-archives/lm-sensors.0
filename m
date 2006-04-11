From: lfriedman@nvidia.com (Lonni J Friedman)
Date: Tue, 11 Apr 2006 17:43:48 +0000
Subject: [lm-sensors] w83l785r driver
Message-Id: <443BEAD4.4090804@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <443BE8D3.6050906@sh.cvut.cz>
In-Reply-To: <443BE8D3.6050906@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Rudolf,
Thanks for your email.  The nvidia-settings utility which ships with the 
driver can be used to interactively poll the GPU's temperature at any 
time, using the following command:

nvidia-settings -q GPUCoreTemp

Please see the man page for nvidia-settings if you have additional 
questions.

Thanks,
Lonni J Friedman
NVIDIA Corporation

On 04/11/2006 10:35 AM Rudolf Marek wrote:
> Hello,
> 
> Please reply to mailing list rather just to me.
> 
>> with the new NVIDIA binary driver the sensor chip onboard my graphics
>> card gets exposed via I2C. So your driver would enable me to monitor the
>> temperature of my graphics card via sensord. Unfortunately the driver
>> seems to have bitrotted a bit. Will you update it and propose it for
>> inclusion into the Kernel? That would be great!
> 
> 
> No I dont have time for this. You may try the w83785ts driver which 
> exports just temperatures.
> 
> And btw the "i2c exposion" is reported not to work anyway. Complain 
> please to nvidia and tell them
> that closed source drivers simply do not work and you get no support 
> from comunity because of close source
> form. They should consider to open the i2c part so we can support it.
> 
> regards
> Rudolf

-----------------------------------------------------------------------------------
This email message is for the sole use of the intended recipient(s) and may contain
confidential information.  Any unauthorized review, use, disclosure or distribution
is prohibited.  If you are not the intended recipient, please contact the sender by
reply email and destroy all copies of the original message.
-----------------------------------------------------------------------------------

