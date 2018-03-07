def has_nested_keys(nested_dict, *keys):
    from jinja2.runtime import Undefined
    if isinstance(nested_dict, Undefined):
        return False

    for key in keys:
        if not isinstance(nested_dict, dict):
            return False
        nested_dict = nested_dict.get(key, {})
    return True if nested_dict != {} else False


class FilterModule(object):
    def filters(self):
        return {
            'has_nested_keys': has_nested_keys
        }
