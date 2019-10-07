package com.flouis.entity;

public class Menu {
    private Long id;

    private Long parentId;
    private Long _parentId; // 父类id，EasyUI页面treegrid需要使用到

    private String name;

    private String url;

    private String icon;

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getParentId() {
        return parentId;
    }

    public void setParentId(Long parentId) {
        this.parentId = parentId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url == null ? null : url.trim();
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon == null ? null : icon.trim();
    }

    public Long get_parentId(){
        this._parentId = this.parentId;
        return this._parentId;
    }

    public void set_parentId(Long _parentId){
        this._parentId = _parentId;
    }
}