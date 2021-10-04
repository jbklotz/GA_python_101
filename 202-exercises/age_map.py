def age_map(age_str):
    try:
        lower, upper = age_str.split('-')
    except:
        return np.nan

    return (int(lower) + int(upper)) / 2
