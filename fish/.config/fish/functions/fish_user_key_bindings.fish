function fish_user_key_bindings
    # ctrl-del
    bind \e\[3\;5~ kill-word

    # ctrl-]
    bind \cH backward-kill-word
end
