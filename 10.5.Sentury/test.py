import sentry_sdk
sentry_sdk.init(
    "https://6a95c9ea7a3b49abacdfae9d50d302fd@o981637.ingest.sentry.io/5936090",

    # Set traces_sample_rate to 1.0 to capture 100%
    # of transactions for performance monitoring.
    # We recommend adjusting this value in production.
    traces_sample_rate=1.0
)

division_by_zero = 1 / 0