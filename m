From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 Nov 2008 14:25:36 +0000
Subject: Re: [lm-sensors] PATCH: add watchdog support to the fschmd driver
Message-Id: <20081111152536.2f9a3b96@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <49194CAD.6000408@redhat.com>
In-Reply-To: <49194CAD.6000408@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Tue, 11 Nov 2008 10:15:30 +0100, Hans de Goede wrote:
> This patch adds support for the watchdog part found in _all_ supported FSC
> sensor chips.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Looks OK to me except for two remaining issues:

> +static int watchdog_open(struct inode *inode, struct file *filp)
> +{
> +	int ret = 0;
> +	struct fschmd_data *pos, *data = NULL;
> +
> +	/* We get called from drivers/char/misc.c with misc_mtx hold, and we
> +	   call misc_register() from fschmd_probe() with watchdog_data_mutex
> +	   hold, as misc_register() takes the misc_mtx lock, this is a possible
> +	   deadlock, so we use mutex_trylock here. */
> +	if (!mutex_trylock(&watchdog_data_mutex))
> +		return -ERESTARTSYS;
> +	list_for_each_entry(pos, &watchdog_data_list, list) {
> +		if (pos->watchdog_miscdev.minor = iminor(inode)) {
> +			data = pos;
> +			break;
> +		}
> +	}
> +	/* Note we can never not have found data, so we don't check for this */
> +	kref_get(&data->kref);
> +	mutex_unlock(&watchdog_data_mutex);
> +
> +	mutex_lock(&data->watchdog_lock);
> +	if (data->watchdog_open_count)
> +		ret = -EBUSY;
> +	data->watchdog_open_count++;
> +	mutex_unlock(&data->watchdog_lock);
> +	if (ret)
> +		return ret;

This looks wrong to me. Did you test concurrent open? If you return
-EBUSY then caller will see its attempt to open the device node fail,
so it will never get to close it. That means that you've incremented
data->watchdog_open_count but it will never get decremented so it will
be >= 1 forever and the watchdog device is no longer usable. I think
this should be:

	if (data->watchdog_open_count)
		ret = -EBUSY;
	else
		data->watchdog_open_count++;

Or am I missing something? You may want to use
test_and_set_bit()/clear_bit() as many other watchdog drivers are doing.

> +
> +	/* Start the watchdog */
> +	watchdog_trigger(data);
> +	filp->private_data = data;
> +
> +	return nonseekable_open(inode, filp);
> +}

> (...)
> +static int watchdog_ioctl(struct inode *inode, struct file *filp,
> +	unsigned int cmd, unsigned long arg)
> +{
> +	static struct watchdog_info ident = {
> +		.options = WDIOF_KEEPALIVEPING | WDIOF_SETTIMEOUT |
> +				WDIOF_CARDRESET,
> +		.identity = "FSC watchdog"
> +	};
> +	int i, ret = 0;
> +	struct fschmd_data *data = filp->private_data;
> +
> +	switch (cmd) {
> +	case WDIOC_GETSUPPORT:
> +		ident.firmware_version = data->revision;
> +		if (!nowayout)
> +			ident.options |= WDIOF_MAGICCLOSE;
> +		if (copy_to_user((void __user *)arg, &ident, sizeof(ident)))
> +			ret = -EFAULT;
> +		break;
> +
> +	case WDIOC_GETSTATUS:
> +		ret = put_user(0, (int __user *)arg);
> +		break;
> +
> +	case WDIOC_GETBOOTSTATUS:
> +		if (data->watchdog_state & FSCHMD_WDOG_STATE_CARDRESET)
> +			ret = put_user(WDIOF_CARDRESET, (int __user *)arg);
> +		else
> +			ret = put_user(0, (int __user *)arg);
> +		break;
> +
> +	case WDIOC_KEEPALIVE:
> +		ret = watchdog_trigger(data);
> +		break;
> +
> +	case WDIOC_GETTIMEOUT:
> +		i = watchdog_get_timeout(data);
> +		ret = put_user(i, (int __user *)arg);
> +		break;
> +
> +	case WDIOC_SETTIMEOUT:
> +		if (get_user(i, (int __user *)arg)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +		ret = watchdog_set_timeout(data, i);
> +		if (ret > 0)
> +			ret = put_user(i, (int __user *)arg);

Shouldn't you push "ret" rather than "i" back to the caller? As I
understand it, "i" is what the user asked for, while "ret" is what the
watchdog will actually do.

> +		break;
> +
> +	case WDIOC_SETOPTIONS:
> +		if (get_user(i, (int __user *)arg)) {
> +			ret = -EFAULT;
> +			break;
> +		}
> +
> +		if (i & WDIOS_DISABLECARD)
> +			ret = watchdog_stop(data);
> +		else if (i & WDIOS_ENABLECARD)
> +			ret = watchdog_trigger(data);
> +		else
> +			ret = -EINVAL;
> +
> +		break;
> +	default:
> +		ret = -ENOTTY;
> +	}
> +
> +	return ret;
> +}

Other than that, it looks OK to me (but remember I am no watchdog
expert, and getting Wim Van Sebroeck to review your patch would make
sense.)

Can you please:
* Address the remaining issues.
* Test again.
* Send an updated version of the patch.

And finally:

* Send a 3rd patch deprecating the fscher and fscpos drivers, planing
  them for removal in, say, 6 months?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
